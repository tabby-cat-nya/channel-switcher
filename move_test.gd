extends Node2D

func _process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		position.x += direction * 10
