extends Node

signal game_win
signal game_lose

@export var win_amount : int = 5
@export var note_frequency : float = 3
@export var paths : Array[Node2D]
var next_note : float = 99


@export_group("Node References")
@export var combo_label : Label

var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_note = note_frequency
	for path in paths:
		path.note_hit.connect(hit_note)
		path.note_miss.connect(miss_note)


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

func hit_note():
	score += 1
	if score >= win_amount:
		game_win.emit()

func miss_note():
	game_lose.emit()
