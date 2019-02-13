extends Spatial

export(NodePath) var portal_exit_path
export(int) var max_recursion = 1
var portal_exit

onready var portal_meshes = $portal_meshes.get_children()

func _ready():
	portal_exit = get_node(portal_exit_path)
	for i in range(max_recursion):
		portal_meshes[i].material_override.set_shader_param("viewport_texture", portal_exit.get_viewport_texture(i))

func _on_portal_activation_body_entered(body):
	body.connect("moved", self, "_on_player_moved")
	show()
#	print("body entered")

func _on_portal_activation_body_exited(body):
	body.disconnect("moved", self, "_on_player_moved")
	hide()
#	print("body left")

func _on_player_moved(player):
	portal_exit.set_camera_position(to_local(player.camera.global_transform.origin))
	var localised_rot = player.camera.global_transform.basis.orthonormalized().get_euler() - global_transform.basis.orthonormalized().get_euler()
	portal_exit.set_camera_rotation(localised_rot)

func _on_portal_entry_body_entered(body):
	if body.get_movement_direction().dot(global_transform.basis.z) < 0:		
		var localised_rot = body.global_transform.basis.orthonormalized().get_euler() - global_transform.basis.orthonormalized().get_euler()
		var target_rot = portal_exit.global_transform.basis.orthonormalized().get_euler() + localised_rot
		body.global_transform.basis = Basis(target_rot)
		var relative_pos = to_local(body.global_transform.origin)
		var new_pos = portal_exit.to_global(relative_pos)
		body.global_transform.origin = new_pos
	