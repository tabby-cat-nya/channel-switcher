extends CharacterBody2D

signal remote_get

@export var SPEED = 200.0
@export var JUMP_VELOCITY = -450.0
@export var remote_sprite : Texture
@export var player_sprite : AnimatedSprite2D
var controls_enabled : bool = true

func _ready() -> void:
	GameManager.allow_movement.connect(change_player_movement)

func _process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		player_sprite.play("jump")


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
		
		if(direction < 0):
			player_sprite.flip_h = true
		elif(direction>0):
			player_sprite.flip_h = false
			
		if(direction != 0 and is_on_floor()):
			player_sprite.play("run")
		elif(is_on_floor()):
			player_sprite.play("idle")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	


func _on_hitbox_area_entered(area: Area2D) -> void:
	#print(area.name)
	if(area.name == "Box"):
		#GameManager.play_zoom_out()
		area.queue_free()
		GameManager.show_item("TV Remote", remote_sprite)
		GameManager.show_chat("Wonder what i can do with this")
	if(is_instance_of(area,Event)): 
		#GameManager.play_zoom_out()
		area.queue_free()
		if(area.type == Event.Type.Chat):
			GameManager.show_chat(area.text)
		elif(area.type == Event.Type.Item):
			GameManager.show_item(area.text, area.texture)
		
	if(area.name == "Zoomer"):
		area.queue_free()
		GameManager.play_zoom_out()
		GameManager.show_chat("I guess it did something..?")
	if(area.name == "TheBitWhereYouTrip"):
		area.queue_free()
		GameManager.show_chat("Ouch, I tripped")
	if(area.name == "BrokenRemote"):
		area.queue_free()
		GameManager.prepare_for_gaming()
	#GameManager.play_zoom_out()
		
	#box event
	#laser event
	#sticky tape event
	pass # Replace with function body.

func change_player_movement(state : bool):
	#print(state) #im an idiot :3
	controls_enabled = state
