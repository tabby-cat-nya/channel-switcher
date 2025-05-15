extends Node

# it is I, the manaegr of the games~

signal zoom_out_signal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_zoom_out():
	zoom_out_signal.emit()
