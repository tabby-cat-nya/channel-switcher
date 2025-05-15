extends Camera2D

@export var target : Node2D
@export var following : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(following):
		global_position = target.global_position
	if(Input.is_action_just_pressed("ui_right")):
		start_arena_cam()
	pass

func start_arena_cam():
	print("weh!")
	following = false
	position = Vector2(320,180)
	#offset = Vector2(0,0)
