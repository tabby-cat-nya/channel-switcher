extends Control
class_name Channel



enum Mode{
	Online,
	Static,
	Offline
}


@export var channel_name : String
@export var channel_scene : PackedScene
@export var dead_channel : bool # mark channel as disabled so game logic doesnt try to switch it on
@export var win_result_tex : Texture
@export var lose_result_tex : Texture
@export var result_display_time : float = 2
@export_group("Node References")
@export var offline_channel_cover : TextureRect
@export var static_channel_cover : TextureRect
@export var game_viewport : SubViewport
@export var result_cover : TextureRect
@export var win_player : AudioStreamPlayer
@export var lose_player : AudioStreamPlayer

var channel_mode : Mode = Mode.Offline
var result_realness : float = 0


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
	result_realness -= delta
	result_cover.modulate = Color(1,1,1,result_realness)

func start_channel():
	start_specific_channel(channel_scene)

func start_specific_channel(scene : PackedScene):
	var new_scene = scene.instantiate()
	new_scene.game_win.connect(win_channel)
	new_scene.game_lose.connect(lose_channel)
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
	GameManager.channel_win.emit()
	result_cover.texture = win_result_tex
	result_realness = result_display_time
	win_player.play()
	end_channel()

func lose_channel():
	GameManager.channel_lose.emit()
	result_cover.texture = lose_result_tex
	result_realness = result_display_time
	lose_player.play()
	end_channel()
