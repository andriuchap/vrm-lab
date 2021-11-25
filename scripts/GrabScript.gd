extends Area

var grabbable_objects : Array
var grabbed_object : RigidBody

var original_parent = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func attempt_grab():
	if grabbable_objects.size() == 0:
		return
	
	var min_dist = 9999.99
	var potential_obj = null
	
	for obj in grabbable_objects:
		var dist = global_transform.origin.distance_to(obj.global_transform.origin)
		if dist < min_dist:
			min_dist = dist
			potential_obj = obj
	
	original_parent = potential_obj.get_parent()
	add_child(potential_obj)
	grabbed_object = potential_obj
	grabbed_object.mode = RigidBody.MODE_RIGID
	grabbed_object.grab(self)

func attempt_release():
	if grabbed_object == null:
		return
	
	
	original_parent.add_child(grabbed_object)
	grabbed_object.release()
	#grabbed_object.mode = RigidBody.MODE_RIGID
	grabbed_object = null

func is_grabbing():
	return grabbed_object != null

func _on_HandOverlap_body_entered(body):
	if body is RigidBody:
		grabbable_objects.append(body)


func _on_HandOverlap_body_exited(body):
	if grabbable_objects.find(body) != -1:
		grabbable_objects.erase(body)
