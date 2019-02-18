extends Camera

class_name MyCamera

signal camera_moved(cam)
export(int) var recursion_level : int = 0

func _ready():
	fov = GameSettings.get_fov()
		
func make_dirty():
	emit_signal("camera_moved", self)