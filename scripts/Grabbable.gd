extends RigidBody

var grabbing_object : Spatial

func grab(grabber):
	grabbing_object = grabber
	
func release():
	grabbing_object = null

func _integrate_forces(state):
	if grabbing_object == null:
		return
	
	var target_location = grabbing_object.global_transform.origin
	var delta = target_location - global_transform.origin
	state.linear_velocity = delta / state.step
