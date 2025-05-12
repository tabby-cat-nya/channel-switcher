extends Node

@export var code_length : int = 8 

@export_group("Node References")
@export var progress1 : ProgressBar
@export var progress2 : ProgressBar
@export var prompt : Label

var numbers_typed : int = 0
var current_number : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress1.value = numbers_typed
	progress2.value = numbers_typed
	prompt.text = str(current_number)
	
	#TODO Surely theres a better way 
	if Input.is_action_just_pressed("bomb_0"):
		enter_number(0)
	elif Input.is_action_just_pressed("bomb_1"):
		enter_number(1)
	elif Input.is_action_just_pressed("bomb_2"):
		enter_number(2)
	elif Input.is_action_just_pressed("bomb_3"):
		enter_number(3)
	elif Input.is_action_just_pressed("bomb_4"):
		enter_number(4)
	elif Input.is_action_just_pressed("bomb_5"):
		enter_number(5)
	elif Input.is_action_just_pressed("bomb_6"):
		enter_number(6)
	elif Input.is_action_just_pressed("bomb_7"):
		enter_number(7)
	elif Input.is_action_just_pressed("bomb_8"):
		enter_number(8)
	elif Input.is_action_just_pressed("bomb_9"):
		enter_number(9)

func enter_number(number : int):
	if(number == current_number):
		numbers_typed += 1
		pick_new_number()
	else:
		#womp womp (lose channel)
		pass

func pick_new_number():
	var new_number = current_number
	while(new_number == current_number):
		new_number = randi_range(0,9)
	current_number = new_number
