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

var newDeck = []
var originalDeck = GameManager.Player_Deck.duplicate()
var currentProgression = GameManager.map_progression

var loot_pool_1 = ["Attack 35", "Defend 35", "Heal 40"]
var loot_pool_2 = ["Attack 40", "Defend 55", "Heal 60"]
var loot_pool_3 = ["Attack 50", "Defend 60", "Heal 70"]
var CardList = []

func _ready():
	newDeck = originalDeck.duplicate()
	match currentProgression:
		1:
			CardList = loot_pool_1
		2:
			CardList = loot_pool_1
		3:
			CardList = loot_pool_1
		4:
			CardList = loot_pool_2
		5:
			CardList = loot_pool_2
		6:
			CardList = loot_pool_2
		7:
			CardList = loot_pool_3
		8:
			CardList = loot_pool_3
		_:
			CardList = loot_pool_3

	var reward_index = randi() % CardList.size()
	reward_card.text = CardList[reward_index]

	for i in range(min(newDeck.size(), 8)):
		var card_data = newDeck[i].split(" ")
		var card_type = card_data[0]
		var card_value = card_data[1] if card_data.size() > 1 else "0"
		var label = "%s\n%s" % [card_type, card_value]
		match i:
			0: button_1.text = label
			1: button_2.text = label
			2: button_3.text = label
			3: button_4.text = label
			4: button_5.text = label
			5: button_6.text = label
			6: button_7.text = label
			7: button_8.text = label

func swap_card(index: int, button: Button) -> void:
	var temp = button.text
	button.text = reward_card.text
	reward_card.text = temp
	newDeck[index] = button.text

func _on_button_1_pressed(): swap_card(0, button_1)
func _on_button_2_pressed(): swap_card(1, button_2)
func _on_button_3_pressed(): swap_card(2, button_3)
func _on_button_4_pressed(): swap_card(3, button_4)
func _on_button_5_pressed(): swap_card(4, button_5)
func _on_button_6_pressed(): swap_card(5, button_6)
func _on_button_7_pressed(): swap_card(6, button_7)
func _on_button_8_pressed(): swap_card(7, button_8)

func _on_confirm_button_pressed() -> void:
	GameManager.Player_Deck = newDeck
	get_tree().change_scene_to_file("res://Scenes/world_map.tscn")
