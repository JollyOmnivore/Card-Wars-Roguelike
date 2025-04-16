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
@onready var confirm_button: Button = $ConfirmButton

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
	
	var reward_index = randi() % CardList.size()
	reward_card.text = CardList[reward_index]
	
	
func _on_button_1_pressed() -> void:
	var CardSwitch = button_1.text
	button_1.text = reward_card.text
	reward_card.text = CardSwitch
	
func _on_button_2_pressed() -> void:
	var CardSwitch = button_2.text
	button_2.text = reward_card.text
	reward_card.text = CardSwitch
	
func _on_button_3_pressed() -> void:
	var CardSwitch = button_3.text
	button_3.text = reward_card.text
	reward_card.text = CardSwitch
	
func _on_button_4_pressed() -> void:
	var CardSwitch = button_4.text
	button_4.text = reward_card.text
	reward_card.text = CardSwitch
	
func _on_button_5_pressed() -> void:
	var CardSwitch = button_5.text
	button_5.text = reward_card.text
	reward_card.text = CardSwitch
	
func _on_button_6_pressed() -> void:
	var CardSwitch = button_6.text
	button_6.text = reward_card.text
	reward_card.text = CardSwitch
	
func _on_button_7_pressed() -> void:
	var CardSwitch = button_7.text
	button_7.text = reward_card.text
	reward_card.text = CardSwitch
	
func _on_button_8_pressed() -> void:
	var CardSwitch = button_8.text
	button_8.text = reward_card.text
	reward_card.text = CardSwitch
	
	
var CardList = ["Attack 20", "Attack 20", "Attack 18", "Heal 15", "Defend 25", "Defend 20"]

func _on_confirm_button_pressed() -> void:
	pass # BACK TO MAP SCENE
