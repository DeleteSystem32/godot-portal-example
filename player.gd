extends KinematicBody
class_name Player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal moved(player)

const move_speed = 6.0

var camera setget ,get_camera

var previous_location = Vector3()

var has_focus = true

func _ready():
	$head/Camera.fov = GameSettings.get_fov()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func get_camera():
	return $head/Camera

# Called when the node enters the scene tree for the first time.
func _process(delta):
	previous_location = global_transform.origin
	var move_dir = Vector3()
	move_dir += (int(Input.is_action_pressed("move_back")) - int(Input.is_action_pressed("move_forward"))) * transform.basis.z
	move_dir += (int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))) * transform.basis.x
	move_dir *= move_speed
	move_and_slide(move_dir)
	
	if move_dir.length_squared() > 0.0001:
		emit_signal("moved", self)
	
func _input(event):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed:
		has_focus = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if event is InputEventMouseMotion && has_focus:
		rotate_y(-event.relative.x/200.0)
		$head.rotate_x(-event.relative.y/200.0)
		emit_signal("moved", self)
		
	if event is InputEventKey && event.pressed && event.scancode == KEY_ESCAPE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		has_focus = false
		
func get_movement_direction():
	return (global_transform.origin - previous_location).normalized()