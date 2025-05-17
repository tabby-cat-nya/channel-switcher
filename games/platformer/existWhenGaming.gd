extends Control

var become_real : bool = false
var realness : float  = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.gaming.connect(appear)
	GameManager.game_over.connect(vanish)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(become_real):
		realness += delta/2
	modulate = Color(1,1,1,clampf(realness, 0,0.5))
	if(realness > 0.5):
		become_real = false

func appear():
	become_real = true

func vanish():
	hide()
