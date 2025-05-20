class_name MouseFollower extends CSGSphere3D

@export var ground_plane: NavSurface

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion or event is InputEventMouseButton:
		var space_state = get_world_3d().direct_space_state
		var camera = get_viewport().get_camera_3d()
		var mouse_pos = event.position
		var from = camera.project_ray_origin(mouse_pos)
		var to = from + camera.project_ray_normal(mouse_pos) * 1000
		var query = PhysicsRayQueryParameters3D.create(from, to)
		query.collide_with_areas = true

		var result = space_state.intersect_ray(query)
		if result.size() != 0:
			print(result)
