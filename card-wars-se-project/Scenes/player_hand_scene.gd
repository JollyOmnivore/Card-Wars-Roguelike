extends Control

@onready var attack_button = $AttackButton
@onready var heal_button = $HealButton
@onready var defend_button = $DefendButton

func _ready() -> void:
	print("PlayerHand scene initialized")
	
	# Connect signals manually
	attack_button.pressed.connect(_on_attack_button_pressed)
	heal_button.pressed.connect(_on_heal_button_pressed)
	defend_button.pressed.connect(_on_defend_button_pressed)
	
	print("Buttons connected successfully!")

func _on_attack_button_pressed():
	print("Attack button pressed")
	var game_manager = get_node("/root/GameManager")
	if game_manager:
		game_manager.player_action("attack")
	else:
		print("ERROR: GameManager not found!")

func _on_heal_button_pressed():
	print("Heal button pressed")
	var game_manager = get_node("/root/GameManager")
	if game_manager:
		game_manager.player_action("heal")
	else:
		print("ERROR: GameManager not found!")

func _on_defend_button_pressed():
	print("Defend button pressed")
	var game_manager = get_node("/root/GameManager")
	if game_manager:
		game_manager.player_action("defend")
	else:
		print("ERROR: GameManager not found!")
