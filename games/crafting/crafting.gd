extends Node

signal game_win
signal game_lose

@export var keys : Array[String]
@export var time_limit : float = 25

@export_group("Node References")
@export var pixel_grid : GridContainer
@export var timer_progress : ProgressBar
var pixels : Array[Control]
var current_time : float = 25

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_pixels()
	current_time = time_limit
	pass # Replace with function body.

func create_pixels():
	for i in range(25):
		var newPixel = load("res://games/crafting/pixel.tscn").instantiate()
		var randomKey = randi_range(0,keys.size()-1)
		newPixel.key = keys[randomKey]
		pixels.append(newPixel)
		pixel_grid.add_child(newPixel)

func enter_letter(letter : String):
	var found : bool = false
	var options : Array[Control]
	for pixel in pixels:
		if (pixel.key == letter and !pixel.activated):
			found = true
			options.append(pixel)
	if(found):
		var randomPixel : int = randi_range(0, options.size()-1)
		options[randomPixel].activate()
	else:
		for i in range(3):
			var randomPixel : int = randi_range(0,pixels.size()-1)
			pixels[randomPixel].deactivate()
	if count_activated():
		pass
		#winner

func count_activated() -> bool:
	var count : int = 0
	for pixel in pixels:
		if pixel.activated:
			count += 1
	if count == 25:
		return true
	else: 
		return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_time -= delta
	timer_progress.value = current_time/time_limit
	if current_time <= 0:
		pass
		#loser
	
	if Input.is_action_just_pressed("crafting_e"):
		enter_letter("E")
	elif Input.is_action_just_pressed("crafting_q"):
		enter_letter("Q")
	elif Input.is_action_just_pressed("crafting_r"):
		enter_letter("R")
	elif Input.is_action_just_pressed("crafting_t"):
		enter_letter("T")
	elif Input.is_action_just_pressed("crafting_y"):
		enter_letter("Y")
	elif Input.is_action_just_pressed("crafting_u"):
		enter_letter("U")
	elif Input.is_action_just_pressed("crafting_f"):
		enter_letter("F")
	elif Input.is_action_just_pressed("crafting_m"):
		enter_letter("M")
