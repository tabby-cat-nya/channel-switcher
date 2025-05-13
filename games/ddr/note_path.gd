extends Node2D

signal note_hit
signal note_miss

@export var note_speed : float = 1
#@export var frequency_min : float = 0.5
#@export var frequency_max : float = 2
@export var arrow_texture : Texture
@export var arrow_rotation : int =0
@export_group("Node References")
@export var detection_area : Area2D
@export var judgement_arrow : Sprite2D
@export var note_spawn_location : Marker2D

#var next_spawn_time : float = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	judgement_arrow.rotation_degrees += arrow_rotation
	#next_spawn_time = randf_range(frequency_min, frequency_max)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#next_spawn_time -= delta
	#if next_spawn_time <= 0:
		#next_spawn_time = randf_range(frequency_min, frequency_max)
		#spawn_note()
	pass

func spawn_note():
	var new_note : Node2D = load("res://games/ddr/ddr_note.tscn").instantiate()
	new_note.sprite.texture = arrow_texture
	new_note.note_speed = note_speed
	new_note.global_position = note_spawn_location.global_position
	new_note.rotation_degrees += arrow_rotation
	get_parent().add_child(new_note)


func _on_kill_area_entered(area: Area2D) -> void:
	note_miss.emit()

func check_hit():
	if (detection_area.get_overlapping_areas().size() > 0):
		note_hit.emit()
		detection_area.get_overlapping_areas()[0].get_parent().queue_free()
