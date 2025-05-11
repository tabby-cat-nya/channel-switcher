extends Control
class_name Channel


@export var channel_name : String
@export var channel_scene : PackedScene
@export_group("Node References")
@export var offline_channel_cover : TextureRect
@export var game_viewport : SubViewport

var channel_online : bool = true

func _ready() -> void:
	var new_scene = channel_scene.instantiate()
	game_viewport.add_child(new_scene)
	
	
	
func _process(delta: float) -> void:
	offline_channel_cover.visible = !channel_online

func start_channel():
	pass

func end_channel():
	pass

func win_channel():
	pass

func lose_channel():
	pass
