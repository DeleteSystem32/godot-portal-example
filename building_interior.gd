extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func set_camera_position(pos):
	$Camera.global_transform.origin = pos
	
func set_camera_basis(bas):
	$Camera.global_transform.basis = bas