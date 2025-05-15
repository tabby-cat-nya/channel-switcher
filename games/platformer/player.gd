extends CharacterBody2D

signal remote_get

@export var SPEED = 200.0
@export var JUMP_VELOCITY = -450.0
var controls_enabled : bool = true


func _process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if(controls_enabled):
		# Handle jump.
		if Input.is_action_just_pressed("platformer_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("platformer_left", "platformer_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_hitbox_area_entered(area: Area2D) -> void:
	#print(area.name)
	if(area.name == "Box"):
		GameManager.play_zoom_out()
	#box event
	#laser event
	#sticky tape event
	pass # Replace with function body.
