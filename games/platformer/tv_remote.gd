extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func _on_broken_remote_area_entered(area: Area2D) -> void:
	if(area.get_parent().name == "Player"): # i knew this would happen
		queue_free()
