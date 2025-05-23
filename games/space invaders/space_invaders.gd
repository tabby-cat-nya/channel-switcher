extends Node

signal game_win
signal game_lose

@export var ufo_speed : float = 0.1
@export_group("Node References")
@export var ufo_path : PathFollow2D

var ufo_progress : float 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ufo_progress += delta * ufo_speed
	ufo_path.progress_ratio = ufo_progress
	if ufo_progress >= 1:
		print("invaders lose")
		game_lose.emit()


func _on_ufo_area_entered(area: Area2D) -> void:
	print("invaders win")
	game_win.emit()
