extends Node

signal game_win
signal game_lose

@export var code_length : int = 5 
@export var time_limit : float  = 8

@export_group("Node References")
@export var progress1 : ProgressBar
@export var progress2 : ProgressBar
@export var prompt : Label
@export var camera : Camera2D

var numbers_typed : int = 0
var current_number : int
var timer : float  = 15
var rot_dir : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pick_new_number()
	timer = time_limit
	if(randi_range(0,1) == 1):
		rot_dir = 1
	else:
		rot_dir = -1
	progress1.max_value = code_length
	progress2.max_value = code_length


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress1.value = numbers_typed
	progress2.value = numbers_typed
	prompt.text = str(current_number)
	timer -= delta
	if(timer <= 0):
		game_lose.emit()
	prompt.modulate = Color(1, timer/time_limit, timer/time_limit)
	progress1.modulate = Color(1, timer/time_limit, timer/time_limit)
	progress2.modulate = Color(1, timer/time_limit, timer/time_limit)
	camera.zoom = Vector2(1.5 - (timer/time_limit)*0.5,1.5 - (timer/time_limit)*0.5) 
	camera.rotation_degrees = rot_dir * (1-timer/time_limit) * 15
	
	#TODO Surely theres a better way 
	for i : int in range(10):
		if Input.is_action_just_pressed("bomb_" + str(i)):
			enter_number(i)
	#if Input.is_action_just_pressed("bomb_0"):
		#enter_number(0)
	#elif Input.is_action_just_pressed("bomb_1"):
		#enter_number(1)
	#elif Input.is_action_just_pressed("bomb_2"):
		#enter_number(2)
	#elif Input.is_action_just_pressed("bomb_3"):
		#enter_number(3)
	#elif Input.is_action_just_pressed("bomb_4"):
		#enter_number(4)
	#elif Input.is_action_just_pressed("bomb_5"):
		#enter_number(5)
	#elif Input.is_action_just_pressed("bomb_6"):
		#enter_number(6)
	#elif Input.is_action_just_pressed("bomb_7"):
		#enter_number(7)
	#elif Input.is_action_just_pressed("bomb_8"):
		#enter_number(8)
	#elif Input.is_action_just_pressed("bomb_9"):
		#enter_number(9)

func enter_number(number : int):
	if(number == current_number):
		numbers_typed += 1
		pick_new_number()
	else:
		#womp womp (lose channel)
		game_lose.emit()
		pass
	if(numbers_typed >= code_length):
		game_win.emit()

func pick_new_number():
	var new_number = current_number
	while(new_number == current_number):
		new_number = randi_range(0,9)
	current_number = new_number
