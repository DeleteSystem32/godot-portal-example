extends Spatial
class_name PortalExit

var viewports = []
var cameras = []

func _ready():
	viewports = get_children()
	for vp in viewports:
		vp.size = get_viewport().size
		var cam = vp.get_node("Camera")
		cam.fov = GameSettings.get_fov()
		cameras.append(vp.get_node("Camera"))

func get_viewport_texture(recursion_level = 0):
	return viewports[recursion_level].get_texture()
	
func set_camera_position_new(cam_pos_global, portal_entry, recursion_level = 0, max_recursion_level = 1):
	var cam_pos_local = portal_entry.to_local(cam_pos_global)
	var new_cam_pos = to_global(cam_pos_local)
#	var next_cam_pos = null
	if recursion_level < max_recursion_level-1:
		set_camera_position_new(new_cam_pos, portal_entry, recursion_level+1, max_recursion_level)
	cameras[recursion_level].global_transform.origin = new_cam_pos
	var cam_floor = to_local(new_cam_pos)
	cam_floor.y = 0
#	cameras[recursion_level].near = Vector3().distance_to(cam_floor)
#	viewports[recursion_level].update_worlds()
	
func set_camera_rotation_new(source_rot, portal_entry_rot, recursion_level = 0, max_recursion_level = 1):
	var localised_rot = source_rot - portal_entry_rot
	var target_rot = global_transform.basis.orthonormalized().get_euler() + localised_rot
	if recursion_level < max_recursion_level - 1:
		set_camera_rotation_new(target_rot, portal_entry_rot, recursion_level+1, max_recursion_level)
	cameras[recursion_level].global_transform.basis = Basis(target_rot)
#	viewports[recursion_level].update_worlds()