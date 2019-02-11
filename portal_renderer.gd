extends MeshInstance

func get_screen_positions():
	var cam = get_viewport().get_camera()
	var res = get_viewport().size
	return [
		cam.unproject_position($top_left.global_transform.origin)/res,
		cam.unproject_position($top_right.global_transform.origin)/res,
		cam.unproject_position($bottom_left.global_transform.origin)/res,
		cam.unproject_position($bottom_right.global_transform.origin)/res
	]
	
func _ready():
	print(get_screen_positions())
	
func _process(delta):
	var cam = get_viewport().get_camera()
	var res = get_viewport().size
	material_override.set_shader_param("top_left", cam.unproject_position($top_left.global_transform.origin)/res)
	material_override.set_shader_param("top_right", cam.unproject_position($top_right.global_transform.origin)/res)
	material_override.set_shader_param("bottom_left", cam.unproject_position($bottom_left.global_transform.origin)/res)
	material_override.set_shader_param("bottom_right", cam.unproject_position($bottom_right.global_transform.origin)/res)