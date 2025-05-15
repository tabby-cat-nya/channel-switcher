extends Control

enum Gamemode{
	Story,
	Endless
}

#mode settings
@export var max_lives = 3
@export var lives = 3
@export var platformer_game : PackedScene
@export var games : Array[PackedScene]
@export var zoom_speed : float = 0.5
@export_group("Node References")
@export var main_camera : Camera2D
@export var outer_channels : Array[Channel]
@export var main_channel : Channel
var gamemode : Gamemode = Gamemode.Story #will be set by manager/menu option
var zooming_out : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.zoom_out_signal.connect(zoom_out)
	GameManager.prepare.connect(get_ready)
	if(gamemode == Gamemode.Story):
		main_camera.zoom = Vector2(3.1,3.1)
		main_channel.start_channel(platformer_game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if(Input.is_action_just_pressed("ui_down")):
		#zoom_out()
	if(zooming_out):
		var zoom_amount : float = clampf(main_camera.zoom.x - delta * zoom_speed,1, 4 )
		main_camera.zoom = Vector2(zoom_amount,zoom_amount)

func zoom_out():
	zooming_out = true

func get_ready():
	for channel in outer_channels:
		channel.channel_mode = channel.Mode.Static
