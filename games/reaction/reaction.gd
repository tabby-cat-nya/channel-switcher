extends Node

signal game_win
signal game_lose

@export var reaction_window : float = 1
@export_group("Node References")
@export var prepare_node : Control
@export var press_node : Control
var time_remaining : float 



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_remaining = randf_range(5,15)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_remaining -= delta
	prepare_node.visible = time_remaining > 0
	press_node.visible = time_remaining <= 0
	if(time_remaining <= 0):
		reaction_window -= delta
	if(Input.is_action_just_pressed("reaction_press")):
		if(time_remaining<=0 and reaction_window > 0):
			pass
			#winner
		else:
			pass
			#loser
	pass
