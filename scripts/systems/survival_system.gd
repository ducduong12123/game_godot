extends RefCounted

const ALLOCATION_LIMIT_TOTAL := 12
const ALLOCATION_LIMIT_EACH := 6
const BATTERY_MAX := 110.0
const HP_MAX := 100.0
const DEMO_TIME_LIMIT_SEC := 480.0


static func allocation_total(allocation: Dictionary) -> int:
	return (
		int(allocation.get("heater", 0))
		+ int(allocation.get("oxygen", 0))
		+ int(allocation.get("water", 0))
		+ int(allocation.get("food", 0))
	)


static func allocation_valid(allocation: Dictionary, battery_now: float) -> bool:
	var total := allocation_total(allocation)
	if total > ALLOCATION_LIMIT_TOTAL:
		return false
	if total > int(floor(battery_now)):
		return false
	if int(allocation.get("heater", 0)) < 0 or int(allocation.get("heater", 0)) > ALLOCATION_LIMIT_EACH:
		return false
	if int(allocation.get("oxygen", 0)) < 0 or int(allocation.get("oxygen", 0)) > ALLOCATION_LIMIT_EACH:
		return false
	if int(allocation.get("water", 0)) < 0 or int(allocation.get("water", 0)) > ALLOCATION_LIMIT_EACH:
		return false
	if int(allocation.get("food", 0)) < 0 or int(allocation.get("food", 0)) > ALLOCATION_LIMIT_EACH:
		return false
	return true


static func apply_turn(state: Dictionary, allocation: Dictionary) -> Dictionary:
	var next_state := state.duplicate(true)

	var heater := int(allocation.get("heater", 0))
	var oxygen := int(allocation.get("oxygen", 0))
	var water := int(allocation.get("water", 0))
	var food := int(allocation.get("food", 0))
	var use_total := float(heater + oxygen + water + food)

	var battery_now := float(state.get("battery", BATTERY_MAX))
	var temp_now := float(state.get("temp", 20.0))
	var ambient_temp := float(state.get("ambient_temp", -30.0))
	var o2_now := float(state.get("o2", 70.0))
	var hydration_now := float(state.get("hydration", 75.0))
	var satiety_now := float(state.get("satiety", 70.0))
	var hp_now := float(state.get("hp", HP_MAX))
	var repair_progress := float(state.get("repair_progress", 0.0))

	next_state["battery"] = maxf(battery_now - use_total, 0.0)
	next_state["o2"] = clampf(o2_now + 2.0 * oxygen - 6.0, 0.0, 100.0)
	next_state["temp"] = clampf(temp_now + 1.6 * heater - 0.1 * (temp_now - ambient_temp), -40.0, 60.0)
	next_state["hydration"] = clampf(hydration_now + 2.0 * water - 6.5, 0.0, 100.0)
	next_state["satiety"] = clampf(satiety_now + 1.6 * food - 5.5, 0.0, 100.0)

	var damage := 0.0
	if float(next_state["o2"]) < 18.0:
		damage += (18.0 - float(next_state["o2"])) * 1.4
	if float(next_state["temp"]) < 10.0:
		damage += (10.0 - float(next_state["temp"])) * 0.7
	if float(next_state["temp"]) > 32.0:
		damage += (float(next_state["temp"]) - 32.0) * 0.6
	if float(next_state["hydration"]) < 25.0:
		damage += (25.0 - float(next_state["hydration"])) * 0.8
	if float(next_state["satiety"]) < 20.0:
		damage += (20.0 - float(next_state["satiety"])) * 0.7

	next_state["hp"] = clampf(hp_now - damage, 0.0, HP_MAX)
	next_state["damage"] = damage
	next_state["game_over"] = false
	next_state["win"] = false
	next_state["death_reason"] = ""

	if float(next_state["o2"]) <= 0.0:
		next_state["game_over"] = true
		next_state["death_reason"] = "Oxy đã cạn."
	elif float(next_state["hp"]) <= 0.0:
		next_state["game_over"] = true
		next_state["death_reason"] = "Phi hành gia gục ngã do cân bằng sinh tồn quá thấp."
	elif float(next_state["battery"]) <= 0.0 and repair_progress < 100.0:
		next_state["game_over"] = true
		next_state["death_reason"] = "Pin cạn trước khi sửa xong phi thuyền."
	elif repair_progress >= 100.0:
		next_state["game_over"] = true
		next_state["win"] = true

	return next_state


static func apply_realtime_pressure(state: Dictionary, delta: float, pressure_factor: float = 1.0) -> Dictionary:
	var next_state := state.duplicate(true)
	var dt := maxf(delta, 0.0) * maxf(pressure_factor, 0.0)

	var battery_now := float(state.get("battery", BATTERY_MAX))
	var temp_now := float(state.get("temp", 20.0))
	var ambient_temp := float(state.get("ambient_temp", -30.0))
	var o2_now := float(state.get("o2", 70.0))
	var hydration_now := float(state.get("hydration", 75.0))
	var satiety_now := float(state.get("satiety", 70.0))
	var hp_now := float(state.get("hp", HP_MAX))

	next_state["battery"] = clampf(battery_now - 0.030 * dt, 0.0, BATTERY_MAX)
	next_state["o2"] = clampf(o2_now - 0.055 * dt, 0.0, 100.0)
	next_state["hydration"] = clampf(hydration_now - 0.040 * dt, 0.0, 100.0)
	next_state["satiety"] = clampf(satiety_now - 0.033 * dt, 0.0, 100.0)
	next_state["temp"] = clampf(temp_now + (ambient_temp - temp_now) * 0.0025 * dt, -40.0, 60.0)

	var damage := 0.0
	if float(next_state["o2"]) < 16.0:
		damage += (16.0 - float(next_state["o2"])) * 0.055 * dt
	if float(next_state["temp"]) < 10.0:
		damage += (10.0 - float(next_state["temp"])) * 0.018 * dt
	if float(next_state["temp"]) < 6.0:
		damage += (6.0 - float(next_state["temp"])) * 0.035 * dt
	if float(next_state["hydration"]) < 18.0:
		damage += (18.0 - float(next_state["hydration"])) * 0.035 * dt
	if float(next_state["satiety"]) < 15.0:
		damage += (15.0 - float(next_state["satiety"])) * 0.030 * dt

	next_state["hp"] = clampf(hp_now - damage, 0.0, HP_MAX)
	next_state["damage"] = damage
	next_state["game_over"] = false
	next_state["win"] = false
	next_state["death_reason"] = ""

	var loss := loss_reason(next_state)
	if loss != "":
		next_state["game_over"] = true
		next_state["death_reason"] = loss

	return next_state


static func loss_reason(state: Dictionary) -> String:
	var repair_progress := float(state.get("repair_progress", 0.0))
	var elapsed_sec := float(state.get("mission_elapsed_sec", 0.0))

	if repair_progress >= 100.0:
		return ""
	if float(state.get("o2", 0.0)) <= 0.0:
		return "Oxy đã cạn. Phi hành gia không thể tiếp tục nhiệm vụ."
	if float(state.get("hp", 0.0)) <= 0.0:
		return "HP về 0. Phi hành gia gục ngã vì sinh tồn thất bại."
	if float(state.get("battery", 0.0)) <= 0.0:
		return "Pin đã cạn trước khi sửa xong phi thuyền."
	if elapsed_sec >= DEMO_TIME_LIMIT_SEC:
		return "Hết thời gian demo 8 phút trước khi sửa xong phi thuyền."
	return ""


static func next_actions_budget(o2: float, hydration: float, satiety: float) -> int:
	var total := o2 + hydration + satiety
	if total >= 160.0:
		return 3
	if total >= 95.0:
		return 2
	return 1
