extends Node

# it is I, the manaegr of the games~

signal zoom_out_signal
signal allow_movement(bool)
signal show_chat_signal(String)
signal show_item_signal(String, Texture)

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
