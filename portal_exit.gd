extends Spatial


func get_viewport_texture():
	$Viewport.size = get_viewport().size
	return $Viewport.get_texture()
	
func set_camera_position(relative_pos):
	$Viewport/Camera.global_transform.origin = to_global(relative_pos)
	
func set_camera_basis(source_basis):
	var target_rot = global_transform.basis.get_euler() + source_basis.get_euler()
	$Viewport/Camera.global_transform.basis = Basis(target_rot)