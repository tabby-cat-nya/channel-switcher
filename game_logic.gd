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
@export_group("Node References")
@export var main_camera : Camera2D
@export var outer_channels : Array[Channel]
@export var main_channel : Channel
var gamemode : Gamemode = Gamemode.Story #will be set by manager/menu option

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(gamemode == Gamemode.Story):
		main_camera.zoom = Vector2(3.1,3.1)
		main_channel.start_channel(platformer_game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
