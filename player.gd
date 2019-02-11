extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const move_speed = 3.0

var camera setget ,get_camera

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func get_camera():
	return $head/Camera

# Called when the node enters the scene tree for the first time.
func _process(delta):
	var move_dir = Vector3()
	move_dir.z += (int(Input.is_action_pressed("move_back")) - int(Input.is_action_pressed("move_forward")))
	move_dir.x += (int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")))
	move_dir *= move_speed
	move_and_slide(move_dir)
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x/200.0)
		$head.rotate_x(-event.relative.y/200.0)
		
	if event is InputEventKey && event.pressed && event.scancode == KEY_ESCAPE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)