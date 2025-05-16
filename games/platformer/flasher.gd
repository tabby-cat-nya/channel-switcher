extends Sprite2D

var flash_delay : float = 0.3
var timer :float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = flash_delay


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	if(timer <= 0):
		visible = !visible
		timer = flash_delay
