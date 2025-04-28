extends Node2D

@onready var reward_card: Button = $"Reward Card"
@onready var reward_card_2: Button = $"Reward Card 2"
@onready var button_1: Button = $Button1
@onready var button_2: Button = $Button2
@onready var button_3: Button = $Button3
@onready var button_4: Button = $Button4
@onready var button_5: Button = $Button5
@onready var button_6: Button = $Button6
@onready var button_7: Button = $Button7
@onready var button_8: Button = $Button8
@onready var confirm_button: Button = $ConfirmButton
@onready var reward_card_one_aura_2: AnimatedSprite2D = $RewardCardOneAura2

var newDeck = []
var originalDeck = GameManager.Player_Deck.duplicate()
var currentProgression = GameManager.map_progression

var loot_pool_1 = ["Attack 35", "Defend 35", "Heal 35"]
var loot_pool_2 = ["Attack 35", "Defend 45", "Heal 40"]
var loot_pool_3 = ["Attack 45", "Defend 50", "Heal 50"]
var CardList = []

var selected_reward_card: Button = null

func _ready():
	newDeck = originalDeck.duplicate()
	match currentProgression:
		1,2,3: #added grouping in switch case
			CardList = loot_pool_1
		4,5,6:
			CardList = loot_pool_2
		7,8:
			CardList = loot_pool_3
		_:
			CardList = loot_pool_3

	var reward_index = randi() % CardList.size()
	reward_card.text = CardList[reward_index]

	if GameManager.EnemyIsElite:
		reward_card_2.visible = true
		reward_card_one_aura_2.visible = true
		reward_index = randi() % CardList.size()
		reward_card_2.text = CardList[reward_index]

	for i in range(min(newDeck.size(), 8)):
		var card_data = newDeck[i].split(" ")
		var card_type = card_data[0]
		var card_value = card_data[1] if card_data.size() > 1 else "0"
		var label = "%s %s" % [card_type, card_value]
		match i:
			0: button_1.text = label
			1: button_2.text = label
			2: button_3.text = label
			3: button_4.text = label
			4: button_5.text = label
			5: button_6.text = label
			6: button_7.text = label
			7: button_8.text = label

func select_reward(button: Button) -> void:
	if selected_reward_card == null:
		selected_reward_card = button
		reward_card.disabled = true
		reward_card_2.disabled = true
		button.disabled = false 

func swap_card(index: int, deck_button: Button) -> void:
	if selected_reward_card == null:
		return # No reward card selected, don't allow swap

	var temp = deck_button.text
	deck_button.text = selected_reward_card.text
	selected_reward_card.text = temp
	newDeck[index] = deck_button.text
	selected_reward_card = null
	reward_card.disabled = false
	reward_card_2.disabled = false


func _on_button_1_pressed(): swap_card(0, button_1)
func _on_button_2_pressed(): swap_card(1, button_2)
func _on_button_3_pressed(): swap_card(2, button_3)
func _on_button_4_pressed(): swap_card(3, button_4)
func _on_button_5_pressed(): swap_card(4, button_5)
func _on_button_6_pressed(): swap_card(5, button_6)
func _on_button_7_pressed(): swap_card(6, button_7)
func _on_button_8_pressed(): swap_card(7, button_8)


func _on_reward_card_pressed(): select_reward(reward_card)
func _on_reward_card_2_pressed(): select_reward(reward_card_2)

func _on_confirm_button_pressed() -> void:
	GameManager.Player_Deck = newDeck
	get_tree().change_scene_to_file("res://Scenes/world_map.tscn")
