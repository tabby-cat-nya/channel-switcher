extends AnimatableBody2D

const offset_multiplier : float = 2
var float_offset : float
var starting_y : float
var elapsed : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	starting_y = position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed += delta
	float_offset = sin(elapsed * offset_multiplier)
	position.y = starting_y + float_offset
