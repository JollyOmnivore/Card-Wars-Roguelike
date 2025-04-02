extends Node2D

@onready var reward_card: Button = $"Reward Card"
@onready var button_1: Button = $Button1
@onready var button_2: Button = $Button2
@onready var button_3: Button = $Button3
@onready var button_4: Button = $Button4
@onready var button_5: Button = $Button5
@onready var button_6: Button = $Button6
@onready var button_7: Button = $Button7
@onready var button_8: Button = $Button8

var newDeck = GameManager.Player_Deck

#var game_manager = get_node("/root/GameManager")
#GameManager.Player_Deck = new Deck


#GameManager.Player_Deck = newDeck
#var game_manager = get_tree().root.get_node_or_null("GameManager")

func _ready():
	pass
	var newDeck = GameManager.Player_Deck

	
func changeCard():
	newDeck[7] = "Attack"
	GameManager.Player_Deck = newDeck
	
	
func _on_reward_card_pressed() -> void:
	pass # Replace with function body.


func _on_button_1_pressed() -> void:
	pass # Replace with function body.

func _on_button_2_pressed() -> void:
	pass # Replace with function body.
	
func _on_button_3_pressed() -> void:
	pass # Replace with function body.
func _on_button_4_pressed() -> void:
	pass # Replace with function body.
func _on_button_5_pressed() -> void:
	pass # Replace with function body.
func _on_button_6_pressed() -> void:
	pass # Replace with function body.
func _on_button_7_pressed() -> void:
	pass # Replace with function body.
func _on_button_8_pressed() -> void:
	pass # Replace with function body.
