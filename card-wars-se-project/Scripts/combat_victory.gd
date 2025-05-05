extends Control
@onready var continue_button: Button = $continue_button


func _on_continue_button_pressed() -> void:
	get_tree().quit()
