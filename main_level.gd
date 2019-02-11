extends Spatial

func _ready():
	$Viewport.size = get_viewport().size
	
func _process(delta):
	$Viewport/building_interior.set_camera_position($player.camera.global_transform.origin)
	$Viewport/building_interior.set_camera_basis($player.camera.global_transform.basis)
	
#	print($portal_quad.get_screen_positions())