extends Spatial

export(NodePath) var portal_exit_path
export(int) var max_recursion = 1
var portal_exit

var portal_meshes = []

func _ready():
	portal_exit = get_node(portal_exit_path)
	var meshes = $portal_meshes.get_children()
	for i in range(min(max_recursion, meshes.size()-1)):
		portal_meshes.append(meshes[i])
		portal_meshes[i].material_override = portal_meshes[i].material_override.duplicate()
		portal_meshes[i].material_override.set_shader_param("viewport_texture", portal_exit.get_viewport_texture(i))

func _on_portal_activation_body_entered(body):
	body.connect("moved", self, "_on_player_moved")
	show()

func _on_portal_activation_body_exited(body):
	body.disconnect("moved", self, "_on_player_moved")
	hide()

func _on_player_moved(player):
	var previous_camera_location = player.camera.global_transform.origin
	var previous_camera_basis = player.camera.global_transform.basis
	var own_rot = global_transform.basis.orthonormalized().get_euler()
	for i in range(max_recursion):
		previous_camera_location = portal_exit.set_camera_position(to_local(previous_camera_location), i)
		var localised_rot = previous_camera_basis.orthonormalized().get_euler() - own_rot
		previous_camera_basis = portal_exit.set_camera_rotation(localised_rot, i)

func _on_portal_entry_body_entered(body):
	if body.get_movement_direction().dot(global_transform.basis.z) < 0:		
		var localised_rot = body.global_transform.basis.orthonormalized().get_euler() - global_transform.basis.orthonormalized().get_euler()
		var target_rot = portal_exit.global_transform.basis.orthonormalized().get_euler() + localised_rot
		body.global_transform.basis = Basis(target_rot)
		var relative_pos = to_local(body.global_transform.origin)
		var new_pos = portal_exit.to_global(relative_pos)
		body.global_transform.origin = new_pos
	