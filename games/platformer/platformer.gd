extends Node

signal game_win
signal game_lose

enum GameStage{
	Warning, # big red highlights (flashing?) show the player where to avoid
	Lasers, # the lasers actively firing 
	None # the starting and ending (offline) state where nothing is happening
}


@export var warning_duration = 5
@export var laser_duration = 2
@export_group("Node References")
@export var score_label : Label
@export var player : CharacterBody2D
@export var skip_location : Marker2D
@export var timer : Timer
@export var warning_areas : Array[Node2D]
@export var laser_areas : Array[Area2D]
@export var lifebar : TextureProgressBar

var game_active : bool = false
var stage : GameStage = GameStage.None
var safe_lane : int # 0,1 or 2 - the others will be hit by lasers

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.skip_intro.connect(rec_skip_intro)
	GameManager.update_data.connect(update_ui)
	GameManager.start_platformer.connect(start_game)
	GameManager.end_platformer.connect(end_game)
	GameManager.game_over.connect(display_game_over)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(3):
		warning_areas[i].visible = stage == GameStage.Warning and safe_lane!=i
		laser_areas[i].visible = stage == GameStage.Lasers and safe_lane!=i
		if(stage == GameStage.Lasers and safe_lane!=i):
			if laser_areas[i].get_overlapping_areas().size()>0:
				end_game()
				game_lose.emit()
		pass
	#warning_areas[0].visible = stage == GameStage.Warning
	#laser_areas[0].visible = stage == GameStage.Lasers
	#todo make sure lasers dont trigger the door/remote/event hitboxes

func update_ui(score : int, lives :int):
	score_label.text = str(score)
	lifebar.value = lives

func rec_skip_intro():
	#teleport player to doorway
	player.global_position = skip_location.global_position
	#maybe bring up an invis wall behind them but it doesnt matter
	pass

func start_game():
	game_active = true
	timer.start(warning_duration)
	safe_lane = randi_range(0,2)
	stage = GameStage.Warning
	pass

func end_game():
	# set stage back to none?
	stage = GameStage.None
	game_active = false
	pass


func _on_timer_timeout() -> void:
	if(stage == GameStage.Warning):
		stage = GameStage.Lasers
		timer.start(laser_duration)
	elif(stage == GameStage.Lasers):
		stage = GameStage.None
		if(game_active):
			game_win.emit()
		end_game()
		
		#if i havent died yet, then win

func display_game_over():
	stage = GameStage.None
	#game_active = true
