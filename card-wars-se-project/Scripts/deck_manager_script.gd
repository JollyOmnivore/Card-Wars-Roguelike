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
	for i in range(min(newDeck.size(), 8)):
		var card_data = newDeck[i].split(" ")
		var card_type = card_data[0]
		var card_value = card_data[1] if card_data.size() > 1 else "0"
		
		match i:
			0: button_1.text = "%s\n%s" % [card_type, card_value]
			1: button_2.text = "%s\n%s" % [card_type, card_value]
			2: button_3.text = "%s\n%s" % [card_type, card_value]
			3: button_4.text = "%s\n%s" % [card_type, card_value]
			4: button_5.text = "%s\n%s" % [card_type, card_value]
			5: button_6.text = "%s\n%s" % [card_type, card_value]
			6: button_7.text = "%s\n%s" % [card_type, card_value]
			7: button_8.text = "%s\n%s" % [card_type, card_value]
	
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
