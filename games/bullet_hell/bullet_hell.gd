extends Node

signal game_win
signal game_lose

@export var spawn_delay : float = 1.5
@export var win_time : float = 15
@export_group("Node References")
@export var spawn_line : Path2D
@export var follow_line : PathFollow2D
@export var win_progress : ProgressBar

var spawn_timer : float = 5
var alive_time : float  = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer = spawn_delay
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn_timer -= delta
	alive_time += delta
	win_progress.value = alive_time/win_time
	if spawn_timer <= 0:
		spawn_timer = spawn_delay
		spawn_new_bullet()
	if alive_time> win_time:
		game_win.emit()
	

func spawn_new_bullet():
	var newBullet : Node2D = load("res://games/bullet_hell/hellBullet.tscn").instantiate()
	follow_line.progress_ratio = randf()
	newBullet.global_position = follow_line.global_position
	#newBullet.heading = -newBullet.global_position.normalized()
	add_child(newBullet)


func _on_hitbox_area_entered(area: Area2D) -> void:
	game_lose.emit()
