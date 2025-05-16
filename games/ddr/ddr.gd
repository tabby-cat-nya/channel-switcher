extends Node

signal game_win
signal game_lose

@export var note_frequency : float = 2
@export var paths : Array[Node2D]
var next_note : float = 99

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_note = note_frequency


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	next_note -= delta
	if(next_note <= 0):
		next_note = note_frequency
		spawn_note()
	if(Input.is_action_just_pressed("ddr_left")):
		detect_hit(0)
	if(Input.is_action_just_pressed("ddr_down")):
		detect_hit(1)
	if(Input.is_action_just_pressed("ddr_up")):
		detect_hit(2)
	if(Input.is_action_just_pressed("ddr_right")):
		detect_hit(3)

func spawn_note():
	var ran_path = randi_range(0, paths.size()-1)
	paths[ran_path].spawn_note()

func detect_hit(lane : int):
	paths[lane].check_hit()
