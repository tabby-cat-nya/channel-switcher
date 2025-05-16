extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_intro_button_pressed() -> void:
	GameManager.are_we_skipping_intro = false
	get_tree().change_scene_to_file("res://game_scene.tscn")


func _on_skip_button_pressed() -> void:
	GameManager.are_we_skipping_intro = true
	get_tree().change_scene_to_file("res://game_scene.tscn")
