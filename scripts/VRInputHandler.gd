extends Node

var controller_states

export var axis_deadzone = 0.75

var teleporter

var hands : Array

func _ready():
	controller_states = {
		0: {
			"axes": Vector2(0,0),
			"wants_to_teleport": false,
			"wanted_to_teleport": false
		},
		1: {
			"axes": Vector2(0,0),
			"wants_to_teleport": false,
			"wanted_to_teleport": false
		}
	}
	teleporter = get_node("../Teleporter")
	
	var left_hand = get_node("../LeftHand")
	var right_hand = get_node("../RightHand")
	hands.push_back(left_hand)
	hands.push_back(right_hand)

func _input(event):
	if event is InputEventJoypadMotion and (event.axis == JOY_AXIS_0 or event.axis == JOY_AXIS_1):
		var axes = Vector2(Input.get_joy_axis(event.device, JOY_AXIS_0), Input.get_joy_axis(event.device, JOY_AXIS_1))
		if axes.y > axis_deadzone and controller_states[event.device].axes.y <= axis_deadzone and not controller_states[event.device].wanted_to_teleport:
			controller_states[event.device].wants_to_teleport = true
			teleporter.start_teleport(event.device)
		elif controller_states[event.device].wants_to_teleport and axes.length() < axis_deadzone:
			controller_states[event.device].wants_to_teleport = false
			teleporter.finish_teleport(event.device)
			
		controller_states[event.device].wanted_to_teleport = controller_states[event.device].wants_to_teleport

	if event is InputEventJoypadButton and event.button_index == JOY_VR_TRIGGER:
		if event.is_pressed():
			hands[event.device].get_hand_overlap().attempt_grab()
		else:
			hands[event.device].get_hand_overlap().attempt_release()
