extends Spatial

export(NodePath) var portal_exit_path
var portal_exit

func _ready():
	portal_exit = get_node(portal_exit_path)
	$portal_mesh.material_override.set_shader_param("viewport_texture", portal_exit.get_viewport_texture())

func _on_portal_activation_body_entered(body):
	body.connect("moved", self, "_on_player_moved")
	show()
	print("body entered")

func _on_portal_activation_body_exited(body):
	body.disconnect("moved", self, "_on_player_moved")
	hide()
	print("body left")

func _on_player_moved(player):
	portal_exit.set_camera_position(to_local(player.camera.global_transform.origin))
	portal_exit.set_camera_basis(player.camera.global_transform.basis)

func _on_portal_entry_body_entered(body):
	var relative_pos = to_local(body.global_transform.origin)
	var new_pos = portal_exit.to_global(relative_pos)
	body.global_transform.origin = new_pos
