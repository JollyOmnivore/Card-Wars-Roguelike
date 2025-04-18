extends Control

@onready var button_1: Button = $Button1
@onready var button_2: Button = $Button2
@onready var button_3: Button = $Button3
var HackCardArray = GameManager.Player_Deck
@onready var deck_display: Label = $DeckDisplay
@onready var discard_display: Label = $DiscardDisplay


#3 arrays
#deck - pulled from GM (deck gm) pop 3 to player hand
#player hand - stored in ph, check for max hand, and values for buttons, pop played hand into discard
#discard pile - popped when played, push onto deck array when deck is empty
var HackCardArray = GameManager.Player_Deck.duplicate()

var handCards = []
var discardCards = []


func _ready() -> void:
	HackCardArray = GameManager.Player_Deck.duplicate()
	print("HEY LOOK HERE ")
	print(HackCardArray)
	handCards = []
	discardCards = []
	HackCardArray.shuffle()
	for i in range(3):
		if HackCardArray.size() > 0:
			handCards.append(HackCardArray.pop_back())
	if HackCardArray.size() > 0:
		button_1.text = handCards[0]
		button_2.text = handCards[1]
		button_3.text = handCards[2]
	


	

func CardUpdates():
	if HackCardArray.size() == 0 and discardCards.size() > 0:
		HackCardArray = discardCards.duplicate()
		discardCards.clear()
		HackCardArray.shuffle()
		print("\n Deck shuffled")

func _on_button_1_pressed():
	Button_Selected()
	var game_manager = get_node("/root/GameManager")
	var card_parts = handCards[0].split(" ")
	var action_type = card_parts[0].to_lower()
	var action_value = int(card_parts[1])

	game_manager.player_action(action_type, action_value)
	
	button_1.visible = false
	discardCards.append(handCards.pop_at(0))
	
	CardUpdates()
	
	if HackCardArray.size() > 0:
		handCards.insert(0, HackCardArray.pop_back())
	
	await get_tree().create_timer(1.5).timeout
	button_1.text = handCards[0]
	button_1.visible = true

func _on_button_2_pressed():
	Button_Selected()
	var game_manager = get_node("/root/GameManager")
	var card_parts = handCards[1].split(" ")
	var action_type = card_parts[0].to_lower()
	var action_value = int(card_parts[1])
	
	game_manager.player_action(action_type, action_value)
	
	button_2.visible = false
	discardCards.append(handCards.pop_at(1))
	
	CardUpdates()
	
	if HackCardArray.size() > 0:
		handCards.insert(1, HackCardArray.pop_back())
	
	await get_tree().create_timer(1.5).timeout
	button_2.text = handCards[1]
	button_2.visible = true

func _on_button_3_pressed():
	Button_Selected()
	var game_manager = get_node("/root/GameManager")
	var card_parts = handCards[2].split(" ")
	var action_type = card_parts[0].to_lower()
	var action_value = int(card_parts[1])
	
	game_manager.player_action(action_type, action_value)
	
	button_3.visible = false
	discardCards.append(handCards.pop_at(2))
	
	CardUpdates()
	
	if HackCardArray.size() > 0:
		handCards.insert(2, HackCardArray.pop_back())
	
	await get_tree().create_timer(1.5).timeout
	button_3.text = handCards[2]
	button_3.visible = true
	
func Button_Selected():
	button_1.disabled = true
	button_2.disabled = true
	button_3.disabled = true
	await get_tree().create_timer(1.5).timeout
	button_1.disabled = false
	button_2.disabled = false
	button_3.disabled = false
	UpdateDeckDisplay()

func UpdateDeckDisplay():
	deck_display.text = "\n Deck\n \n \n" + str(HackCardArray.size())
	discard_display.text = "\n Discard\n \n \n" + str(discardCards.size())
