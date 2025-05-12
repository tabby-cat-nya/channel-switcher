extends ColorRect


@export var end_color : Color = Color.PURPLE
@export_group("Node References")
@export var key_label : Label
var key : String = "Q"
var activated : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	key_label.visible = !activated
	key_label.text = key
	if(activated):
		color = end_color
	else:
		color = Color.WHITE

func activate():
	activated = true
	
func deactivate():
	activated = false
