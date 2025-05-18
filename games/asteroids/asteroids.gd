extends Node

signal game_win
signal game_lose

@export var asteroid_spawns : Array[Node2D]
@export var win_progress : ProgressBar
@export var win_time : float = 15
var alive_time : float  =0
@export var spawn_time : float = 3
@export var player : Node2D
var timer : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = spawn_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	win_progress.value = alive_time/win_time
	timer -= delta
	alive_time += delta
	if timer <0:
		spawn_new_asteroid()
		timer = spawn_time
	if alive_time >= win_time:
		print("Asteroid win")
		game_win.emit()

func spawn_new_asteroid():
	var newAsteroid : Node2D = load("res://games/asteroids/asteroid.tscn").instantiate()
	var randSpawn : int = randi_range(0,3)
	newAsteroid.global_position = asteroid_spawns[randSpawn].global_position
	newAsteroid.target_pos = player.global_position
	#newBullet.heading = -newBullet.global_position.normalized()
	add_child(newAsteroid)


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Asteroid lose")
	game_lose.emit()
