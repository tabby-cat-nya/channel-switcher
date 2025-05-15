extends AnimatableBody2D

@export var open_pos_y : float
@export var close_pos_y : float
@export var open : bool = true
@export var move_speed : float = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.gaming.connect(close_door)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(open):
		position.y = clampf(position.y - delta*move_speed, open_pos_y, close_pos_y)
	else:
		position.y = clampf(position.y + delta*move_speed, open_pos_y, close_pos_y)

func open_door():
	open = true

func close_door():
	open = false
