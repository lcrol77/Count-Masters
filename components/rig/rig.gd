extends Node3D

@export var move_speed: float = 5.0
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var mouse_follower: MouseFollower = $MouseFollower

func _physics_process(delta: float) -> void:
	if not ray_cast_3d.is_colliding():
		return
	position.z += -move_speed * delta
	
	
