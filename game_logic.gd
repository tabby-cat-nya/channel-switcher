extends Control

enum Gamemode{
	Story,
	Endless
}

#mode settings

signal game_over(score : int)

@export var max_lives = 3
@export var lives = 3
@export var platformer_game : PackedScene
@export var games : Array[PackedScene]
@export var zoom_speed : float = 0.5
@export_group("Channel Rules")
@export var target_channels : float = 1.5
@export var channel_growth_per_min : float = 4

@export_group("Node References")
@export var main_camera : Camera2D
@export var outer_channels : Array[Channel]
@export var main_channel : Channel
var gamemode : Gamemode = Gamemode.Story #will be set by manager/menu option
var zooming_out : bool = false
var gameplay : bool = false # becomes true when the game starts
var score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.zoom_out_signal.connect(zoom_out)
	GameManager.prepare.connect(get_ready)
	GameManager.gaming.connect(start_game)
	GameManager.channel_win.connect(rec_channel_win)
	GameManager.channel_lose.connect(rec_channel_lose)
	if(gamemode == Gamemode.Story):
		
		main_camera.zoom = Vector2(3.1,3.1)
		main_channel.start_specific_channel(platformer_game)
	if(GameManager.are_we_skipping_intro):
		zooming_out = true
		main_camera.zoom = Vector2(1,1)
		GameManager.skip_intro.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if(Input.is_action_just_pressed("ui_down")):
		#main_channel.start_channel() #so this works
	if(zooming_out):
		var zoom_amount : float = clampf(main_camera.zoom.x - delta * zoom_speed,1, 3.1 ) #was 4?
		main_camera.zoom = Vector2(zoom_amount,zoom_amount)
	else:
		var zoom_amount : float = clampf(main_camera.zoom.x + delta * zoom_speed,1, 3.1 ) #was 4?
		main_camera.zoom = Vector2(zoom_amount,zoom_amount)
	if(gameplay):
		game_loop(delta)

func zoom_out():
	zooming_out = true

func zoom_in():
	zooming_out = false

func get_ready():
	for channel in outer_channels:
		channel.channel_mode = channel.Mode.Static

func start_game():
	gameplay = true
	main_channel.start_channel()

func game_loop(delta : float):
	target_channels += channel_growth_per_min * (delta/60)
	var online_channels : Array[Channel]
	var offline_channels : Array[Channel]
	# sort all the channels into online and offline
	#if main_channel.channel_mode == Channel.Mode.Online:
	if main_channel.platformer_online:
		online_channels.append(main_channel)
	else: 
		offline_channels.append(main_channel)
	for channel in outer_channels:
		if(channel.channel_mode == Channel.Mode.Online):
			online_channels.append(channel)
		elif(!channel.dead_channel):
			offline_channels.append(channel)
	# if i need to switch a channel online, then pick one and run tis start channel method
	#print("Online Channels: " + str(online_channels.size()))
	if(online_channels.size() < target_channels and offline_channels.size() > 0):
		var random_channel_number = randi_range(0, offline_channels.size()-1)
		var random_game = randi_range(0, games.size()-1)
		offline_channels[random_channel_number].start_channel()
		#if(offline_channels[random_channel_number] != main_channel):
			#offline_channels[random_channel_number].start_channel()
			#picking a random game is cool but we cant have two of the same!
			#offline_channels[random_channel_number].start_specific_channel(games[random_game])
		#else:
			#main_channel.start_channel()

func rec_channel_win():
	score += 1
	GameManager.send_update_data(score, lives)
	
func rec_channel_lose():
	lives -= 1
	GameManager.send_update_data(score, lives)
	if(lives <= 0):
		game_over_gg()

func game_over_gg():
	zoom_in()
	game_over.emit()
	gameplay = false
	main_channel.end_channel()
	for channel in outer_channels:
		channel.make_offline()
