class_name NavNPC extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var random_position := Vector3.ZERO
		random_position.x = randf_range(-5,5)
		random_position.z = randf_range(-5,5)
		navigation_agent_3d.set_target_position(random_position)

func _physics_process(delta: float) -> void:
	var dest = navigation_agent_3d.get_next_path_position()
	var l_dest = dest - global_position
	var dir = l_dest.normalized()
	velocity = dir * 5
	move_and_slide()
