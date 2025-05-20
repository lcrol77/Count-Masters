class_name NavNPC extends CharacterBody3D

@export var movement_speed: float = 4.0
@export var nav_target: Node3D
@onready var navigation_agent: NavigationAgent3D = get_node("NavigationAgent3D")

func _ready() -> void:
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))

func set_movement_target(movement_target: Vector3) -> void:
	navigation_agent.target_position = movement_target

func _process(delta: float) -> void:
	var pos := Vector3.ZERO
	pos.x = nav_target.position.x
	pos.z = nav_target.position.z
	navigation_agent.set_target_position(pos)

func _physics_process(delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		return
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var current_agent_position: Vector3 = global_position
	var new_velocity: Vector3 = (next_path_position - current_agent_position).normalized() * movement_speed
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity: Vector3)-> void:
	velocity = safe_velocity
	move_and_slide()
