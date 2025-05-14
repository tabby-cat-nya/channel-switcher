extends Camera2D
class_name CamFollow

@export var target : Node2D
@export var following : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(following):
		global_position = target.global_position
