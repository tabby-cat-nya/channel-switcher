extends AnimatableBody2D

const offset_multiplier : float = 2
var float_offset : float
var starting_y : float
var elapsed : float
var realness : float = 0
var becoming_real : bool = false
@export var collider : CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.gaming.connect(fade_in)
	GameManager.game_over.connect(fade_out)
	starting_y = position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed += delta
	float_offset = sin(elapsed * offset_multiplier)
	position.y = starting_y + float_offset
	collider.disabled = realness < 0.1
	modulate = Color(1,1,1,realness)
	if(becoming_real):
		realness = clampf(realness + delta, 0 , 1)
	else:
		realness = clampf(realness - delta, 0 , 1)
	#if(Input.is_action_just_pressed("ui_left")):
		#becoming_real = !becoming_real

func fade_out():
	becoming_real = false

func fade_in():
	becoming_real = true
