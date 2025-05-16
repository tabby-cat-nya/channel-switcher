extends Node

# it is I, the manaegr of the games~

signal zoom_out_signal
signal allow_movement(bool)
signal show_chat_signal(String)
signal show_item_signal(String, Texture)
signal prepare
signal gaming

@export var broken_tv_remote : Texture

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
	GameManager.show_chat("[color=red]ALERT: Intruder Detected... Initiating Security Protocol...")
	pass

func actually_gaming():
	gaming.emit()
