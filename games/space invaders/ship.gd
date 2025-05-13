extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var time_per_bullet : float = 2
var next_bullet : float  =2
@export var bullet_spawn : Marker2D
@export var bullet_goal : Marker2D

func _ready() -> void:
	next_bullet = time_per_bullet

func _process(delta: float) -> void:
	next_bullet -= delta
	if next_bullet <= 0:
		shoot()

func shoot():
	next_bullet = time_per_bullet
	var new_bullet : Node2D = load("res://games/asteroids/bullet.tscn").instantiate() as Node2D
	new_bullet.goal = bullet_goal.global_position
	new_bullet.position = bullet_spawn.global_position
	get_parent().add_child(new_bullet)

func _physics_process(delta: float) -> void:
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("invaders_left", "invaders_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
