extends Control
class_name Channel

signal channel_win
signal channel_lose

@export var channel_name : String
@export var channel_scene : PackedScene
@export_group("Node References")
@export var offline_channel_cover : TextureRect
@export var game_viewport : SubViewport

var channel_online : bool = false

func _ready() -> void:
	#var new_scene = channel_scene.instantiate()
	#game_viewport.add_child(new_scene)
	#start_channel(channel_scene)
	#if(channel_name == "Platformer"):
		#start_channel(channel_scene)
	pass
	
	
func _process(delta: float) -> void:
	offline_channel_cover.visible = !channel_online

func start_channel(scene : PackedScene):
	var new_scene = scene.instantiate()
	game_viewport.add_child(new_scene)
	channel_online = true

func end_channel():
	channel_online = false
	game_viewport.get_child(0).queue_free()

func win_channel():
	channel_win.emit()
	end_channel()

func lose_channel():
	channel_lose.emit()
	end_channel()
