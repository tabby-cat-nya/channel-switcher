extends RigidBody2D

@export var rotation_force = 1
@export var drag = 2
@export var top_speed = 6
@export var time_per_shot : float = 1
var reload_time : float = 99
@export var bullet_goal : Marker2D
@export var bullet_spawn : Marker2D

func _ready() -> void:
	reload_time = time_per_shot

func _process(delta: float) -> void:
	var input = Input.get_axis("asteroids_left","asteroids_right")
	angular_velocity += rotation_force * delta * input
	#print(angular_velocity)
	angular_velocity = clampf(angular_velocity, -top_speed, top_speed)
	if(input == 0):
		angular_velocity = move_toward(angular_velocity, 0, delta * drag)
	
	reload_time -= delta
	if reload_time <= 0:
		reload_time = time_per_shot
		shoot()

func shoot():
	# instantiate bullet
	#print("meow")
	var new_bullet : Node2D = load("res://games/asteroids/bullet.tscn").instantiate() as Node2D
	new_bullet.goal = bullet_goal.global_position
	new_bullet.position = bullet_spawn.global_position
	get_parent().add_child(new_bullet)
