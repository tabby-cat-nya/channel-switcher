extends Control

enum Page{
	Menu,
	Credits
}
var menu_page : Page = Page.Menu
@export var menu_container : Control
@export var credits_container : Control
@export var exit_button : Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	if OS.get_name() == "Web":
		exit_button.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	menu_container.visible = menu_page == Page.Menu
	credits_container.visible = menu_page == Page.Credits


func _on_intro_button_pressed() -> void:
	GameManager.are_we_skipping_intro = false
	get_tree().change_scene_to_file("res://game_scene.tscn")


func _on_skip_button_pressed() -> void:
	GameManager.are_we_skipping_intro = true
	get_tree().change_scene_to_file("res://game_scene.tscn")


func _on_credits_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))


func _on_credits_button_pressed() -> void:
	menu_page = Page.Credits


func _on_back_button_pressed() -> void:
	menu_page = Page.Menu
