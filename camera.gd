extends Spatial

signal camera_moved
onready var previous_pos : Vector3 = transform.origin
export(int) var recursion_level : int = 0

func _ready():
	pass
	
func _process(delta):
	if transform.origin != previous_pos:
		emit_signal("camera_moved")