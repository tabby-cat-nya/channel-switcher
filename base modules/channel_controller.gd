extends Control
class_name Channel

signal channel_win
signal channel_lose

enum Mode{
	Online,
	Static,
	Offline
}


@export var channel_name : String
@export var channel_scene : PackedScene
@export_group("Node References")
@export var offline_channel_cover : TextureRect
@export var static_channel_cover : TextureRect
@export var game_viewport : SubViewport

var channel_mode : Mode = Mode.Offline

func _ready() -> void:
	#var new_scene = channel_scene.instantiate()
	#game_viewport.add_child(new_scene)
	#start_channel(channel_scene)
	#if(channel_name == "Platformer"):
		#start_channel(channel_scene)
	pass
	
	
func _process(delta: float) -> void:
	offline_channel_cover.visible = channel_mode == Mode.Offline
	static_channel_cover.visible = channel_mode == Mode.Static

func start_channel():
	var new_scene = channel_scene.instantiate()
	game_viewport.add_child(new_scene)
	channel_mode = Mode.Online

func start_specific_channel(scene : PackedScene):
	var new_scene = scene.instantiate()
	game_viewport.add_child(new_scene)
	channel_mode = Mode.Online

func end_channel():
	channel_mode = Mode.Static
	game_viewport.get_child(0).queue_free()

func make_static():
	channel_mode = Mode.Static 

func make_offline():
	channel_mode = Mode.Offline

func win_channel():
	channel_win.emit()
	end_channel()

func lose_channel():
	channel_lose.emit()
	end_channel()
