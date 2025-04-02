extends Control
@onready var continue_button: Button = $continue_button


func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/world_map.tscn")
