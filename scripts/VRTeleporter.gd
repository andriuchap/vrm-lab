extends Node

func start_teleport(hand_id):
	if hand_id == 0:
		activate_left_teleporter()
	else:
		activate_right_teleporter()
	
func activate_left_teleporter():
	var hand = get_hand(0)
	if not hand.get_hand_overlap().is_grabbing():
		hand.activate_teleporter()
		get_hand(1).deactivate_teleporter()
	
func activate_right_teleporter():
	var hand = get_hand(1)
	if not hand.get_hand_overlap().is_grabbing():
		hand.activate_teleporter()
		get_hand(0).deactivate_teleporter()

func finish_teleport(hand_id):
	get_hand(hand_id).execute_teleport()

func get_hand(hand_id):
	if hand_id == 0:
		return get_node("../LeftHand")
	else:
		return get_node("../RightHand")
