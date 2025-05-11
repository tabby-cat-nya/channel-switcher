extends Area2D

@export var speed : float  = 100
var goal : Vector2

func _process(delta: float) -> void:
	position = position.move_toward(goal,delta * speed)
