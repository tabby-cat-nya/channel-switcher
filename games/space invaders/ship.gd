extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var bullet_cooldown : float = 1
var cooldown : float  = 0
@export var bullet_spawn : Marker2D
@export var bullet_goal : Marker2D

func _ready() -> void:
	cooldown = 0

func _process(delta: float) -> void:
	cooldown -= delta
	if cooldown <= 0 and Input.is_action_just_pressed("invaders_shoot"):
		shoot()

func shoot():
	cooldown = bullet_cooldown
	var new_bullet : Node2D = load("res://games/space invaders/invadersBullet.tscn").instantiate() as Node2D
	#new_bullet.goal = bullet_goal.global_position
	new_bullet.position = bullet_spawn.global_position
	get_parent().add_child(new_bullet)

func _physics_process(delta: float) -> void:
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("invaders_left", "invaders_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		

	move_and_slide()
