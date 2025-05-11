extends RigidBody2D

@export var rotation_force = 1
@export var drag = 2
@export var top_speed = 6

func _process(delta: float) -> void:
	var input = Input.get_axis("asteroids_left","asteroids_right")
	angular_velocity += rotation_force * delta * input
	print(angular_velocity)
	angular_velocity = clampf(angular_velocity, -top_speed, top_speed)
	if(input == 0):
		angular_velocity = move_toward(angular_velocity, 0, delta * drag)
