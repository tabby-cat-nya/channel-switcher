extends PanelContainer

signal display_finished

@export var rich_label : RichTextLabel
var active : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.show_chat_signal.connect(displayMessage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	visible = active
	
	if Input.is_action_just_pressed("advance_prompt"):
		hideMessage()
		

func hideMessage():
	active = false
	GameManager.change_player_movement(true)

func displayMessage(message = "String"):
	rich_label.text = message
	active = true
	GameManager.change_player_movement(false)
