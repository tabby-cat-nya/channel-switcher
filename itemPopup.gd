extends PanelContainer

@export var texture_rect : TextureRect
@export var label : RichTextLabel
var active : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.show_item_signal.connect(showPopup)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	visible = active
	if(Input.is_action_just_pressed("advance_prompt")):
		hidePopup()

func showPopup(item_name : String, item_texture : Texture):
	label.text = item_name
	texture_rect.texture = item_texture
	active = true
	GameManager.change_player_movement(false)
	
func hidePopup():
	active = false
	GameManager.change_player_movement(true)
