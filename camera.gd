extends Spatial

class_name MyCamera

signal camera_moved(cam)
onready var previous_pos : Vector3 = global_transform.origin
onready var previous_rot : Vector3 = global_transform.basis.get_euler()
export(int) var recursion_level : int = 0

func _ready():
	pass
	
func _physics_process(delta):
	
	if global_transform.origin != previous_pos || global_transform.basis.get_euler() != previous_rot:
		print(self)
		emit_signal("camera_moved", self)
		previous_pos = global_transform.origin
		previous_rot = global_transform.basis.get_euler()