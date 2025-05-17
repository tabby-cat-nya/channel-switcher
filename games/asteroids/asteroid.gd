extends Area2D

var speed : float = 50
var target_pos : Vector2 
@export var sprite : Sprite2D
var spin_speed : float = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sprite.rotation_degrees += spin_speed * delta
	global_position = global_position.move_toward(target_pos, delta * speed)


func _on_area_entered(area: Area2D) -> void:
	queue_free()
