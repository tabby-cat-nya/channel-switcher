extends Node

signal game_win
signal game_lose

@export_group("Node References")
@export var score_label : Label
@export var player : CharacterBody2D
@export var skip_location : Marker2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.skip_intro.connect(rec_skip_intro)
	GameManager.update_data.connect(update_ui)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_ui(score : int, lives :int):
	score_label.text = str(score)

func rec_skip_intro():
	#teleport player to doorway
	player.global_position = skip_location.global_position
	#maybe bring up an invis wall behind them but it doesnt matter
	pass
