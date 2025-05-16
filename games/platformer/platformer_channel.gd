extends Channel

func _process(delta: float) -> void:
	offline_channel_cover.visible = channel_mode == Mode.Offline
	static_channel_cover.visible = channel_mode == Mode.Static

func start_specific_channel(scene : PackedScene):
	var new_scene = scene.instantiate()
	game_viewport.add_child(new_scene)
	channel_mode = Mode.Online

func start_channel():
	var new_scene = channel_scene.instantiate()
	game_viewport.add_child(new_scene)
	channel_mode = Mode.Online

func end_channel():
	channel_mode = Mode.Static
	modulate = Color.DIM_GRAY
	# TODO: a bunch of stuff here
	#game_viewport.get_child(0).queue_free()
