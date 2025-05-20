class_name MouseFollower extends CSGSphere3D

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion or event is InputEventMouseButton:
		var space_state = get_world_3d().direct_space_state
		var camera = get_viewport().get_camera_3d()
		var mouse_pos = event.position
		var from = camera.project_ray_origin(mouse_pos)
		var to = from + camera.project_ray_normal(mouse_pos) * 1000
		var query = PhysicsRayQueryParameters3D.create(from, to)
		#TODO: setup a collision mask so that this can only collide with the floor
		var result = space_state.intersect_ray(query)
		if result.size() != 0:
			position.x = result.position.x
			position.z = result.position.z
			position.y = 0
