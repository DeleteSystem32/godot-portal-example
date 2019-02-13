extends Spatial

var viewports = []
var cameras = []

func _ready():
	viewports = get_children()
	for vp in viewports:
		vp.size = get_viewport().size
		cameras.append(vp.get_node("Camera"))

func get_viewport_texture(recursion_level = 0):
#	$Viewport.size = get_viewport().size
	return viewports[recursion_level].get_texture()
	
func set_camera_position(relative_pos, recursion_level = 0):
	cameras[recursion_level].global_transform.origin = to_global(relative_pos)
	return cameras[recursion_level].global_transform.origin
	
func set_camera_rotation(source_rot, recursion_level = 0):
	var target_rot = global_transform.basis.orthonormalized().get_euler() + source_rot
	cameras[recursion_level].global_transform.basis = Basis(target_rot)
	return cameras[recursion_level].global_transform.basis