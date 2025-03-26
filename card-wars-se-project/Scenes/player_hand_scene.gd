extends Control

@onready var button_1: Button = $Button1
@onready var button_2: Button = $Button2
@onready var button_3: Button = $Button3
var HackCardArray = ["Attack","Attack","Attack","Attack","Attack","Defend","Defend","Heal"]
#3 arrays
#deck - pulled from GM (deck gm) pop 3 to player hand
#player hand - stored in ph, check for max hand, and values for buttons, pop played hand into discard
#discard pile - popped when played, push onto deck array when deck is empty

func _ready() -> void:
	# Connect signals manually
	button_1.pressed.connect(_on_button_1_pressed)
	button_2.pressed.connect(_on_button_2_pressed)
	button_3.pressed.connect(_on_button_3_pressed)
	button_1.text = "Defend"
	button_2.text = "Attack"
	button_3.text = "Heal"

func _on_button_1_pressed():
	Button_Selected()
	var game_manager = get_node("/root/GameManager")
	var button_1_card = button_1.text
	game_manager.player_action(button_1_card.to_lower())
	button_1.visible= false
	button_1.text = HackCardArray.pick_random()
	await get_tree().create_timer(1.5).timeout
	button_1.visible= true
	#print(button_1_card.to_lower())


func _on_button_2_pressed():
	Button_Selected()
	var game_manager = get_node("/root/GameManager")
	var button_2_card = button_2.text
	game_manager.player_action(button_2_card.to_lower())
	button_2.visible= false
	button_2.text = HackCardArray.pick_random()
	await get_tree().create_timer(1.5).timeout
	button_2.visible= true


func _on_button_3_pressed():
	Button_Selected()
	var game_manager = get_node("/root/GameManager")
	var button_3_card = button_3.text
	game_manager.player_action(button_3_card.to_lower())
	button_3.visible= false
	button_3.text = HackCardArray.pick_random()
	await get_tree().create_timer(1.5).timeout
	button_3.visible= true
	
	
func Button_Selected():
	button_1.disabled = true
	button_2.disabled = true
	button_3.disabled = true
	await get_tree().create_timer(1.5).timeout
	button_1.disabled = false
	button_2.disabled = false
	button_3.disabled = false
