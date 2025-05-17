extends Node

# it is I, the manaegr of the games~

signal zoom_out_signal
signal allow_movement(bool)
signal show_chat_signal(String)
signal show_item_signal(String, Texture)
signal prepare
signal gaming
signal channel_win
signal channel_lose
signal update_data(score : int, lives : int)
signal skip_intro
signal start_platformer
signal end_platformer
signal game_over

@export var broken_tv_remote : Texture
var are_we_skipping_intro : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_zoom_out():
	zoom_out_signal.emit()

func show_chat(text : String):
	show_chat_signal.emit(text)

func show_item(text : String, texture : Texture):
	show_item_signal.emit(text,texture)
	
func change_player_movement(state : bool):
	allow_movement.emit(state)

func prepare_for_gaming():
	#switch displays to satic
	prepare.emit()
	# as soon as the player dismisses this chat the game is afoot
	GameManager.show_item("Broken TV Remote", broken_tv_remote)
	GameManager.show_chat("[color=red][shake]ALERT: Intruder Detected... Initiating Security Protocol...")
	pass

func actually_gaming():
	gaming.emit()
	start_platformer.emit()

func send_update_data(score : int, lives: int):
	update_data.emit(score, lives)

func send_game_over():
	game_over.emit()
