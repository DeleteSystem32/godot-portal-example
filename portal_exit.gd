extends Spatial


func get_viewport_texture(recursion_level = 0):
	$Viewport.size = get_viewport().size
	return $Viewport.get_texture()
	
func set_camera_position(relative_pos):
	$Viewport/Camera.global_transform.origin = to_global(relative_pos)
	return $Viewport/Camera.global_transform.origin
	
func set_camera_rotation(source_rot):
	var target_rot = global_transform.basis.orthonormalized().get_euler() + source_rot
	$Viewport/Camera.global_transform.basis = Basis(target_rot)
	return $Viewport/Camera.global_transform.basis