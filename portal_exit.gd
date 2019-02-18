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
	
func set_camera_position(cam_pos_global, portal_entry, recursion_level = 0):
	var cam_pos_local = portal_entry.to_local(cam_pos_global)
	var new_cam_pos = to_global(cam_pos_local)
	cameras[recursion_level].global_transform.origin = new_cam_pos
	
func set_camera_rotation(source_rot:Quat, portal_entry_rot:Quat, recursion_level = 0):
	var localised_rot = QuatHelpers.localise_rotation(source_rot, portal_entry_rot)
	var target_rot = (Quat(global_transform.basis) * localised_rot).normalized()
	cameras[recursion_level].global_transform.basis = Basis(target_rot)

func update_camera(previous_camera, portal_entry):
	if previous_camera.recursion_level <= portal_entry.max_recursion:
		set_camera_position(previous_camera.global_transform.origin, portal_entry, previous_camera.recursion_level)
		set_camera_rotation(Quat(previous_camera.global_transform.basis.orthonormalized()),
			Quat(portal_entry.global_transform.basis.orthonormalized()), previous_camera.recursion_level)
			
		cameras[previous_camera.recursion_level].make_dirty()