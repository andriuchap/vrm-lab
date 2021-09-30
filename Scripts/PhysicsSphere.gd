extends RigidBody


# Declare member variables here. Examples:
# var a = 2
export var color = Color(1.0, 0.0, 0.0, 1.0)


# Called when the node enters the scene tree for the first time.
func _ready():
	var material = SpatialMaterial
	material.albedo_color = color
	$CSGSphere.material = material


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
