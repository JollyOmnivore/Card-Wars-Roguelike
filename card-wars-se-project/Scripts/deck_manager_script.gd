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

func _ready():
	pass
	var newDeck = GameManager.Player_Deck
	button_1.text = newDeck[0]
	button_2.text = newDeck[1]
	button_3.text = newDeck[2]
	button_4.text = newDeck[3]
	button_5.text = newDeck[4]
	button_6.text = newDeck[5]
	button_7.text = newDeck[6]
	button_8.text = newDeck[7]
	
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
