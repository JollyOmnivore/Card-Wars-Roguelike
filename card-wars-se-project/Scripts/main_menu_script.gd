extends Control
@onready var quit_button: Button = $quit_button
@onready var new_game_button: Button = $new_game_button


func _on_quit_button_pressed() -> void:
	get_tree().quit()



func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/world_map.tscn")
