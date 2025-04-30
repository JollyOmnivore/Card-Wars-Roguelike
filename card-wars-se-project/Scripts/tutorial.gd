extends Control
@onready var start_panel: Panel = $StartPanel
@onready var start_button: Button = $StartPanel/StartButton
@onready var battle_panel: Panel = $BattlePanel
@onready var battle_button: Button = $BattlePanel/BattleButton
@onready var enemy_panel: Panel = $EnemyPanel
@onready var enemy_button: Button = $EnemyPanel/EnemyButton
@onready var player_panel: Panel = $PlayerPanel
@onready var player_button: Button = $PlayerPanel/PlayerButton
@onready var card_panel: Panel = $CardPanel
@onready var card_button: Button = $CardPanel/CardButton
@onready var atk_boost_panel: Panel = $AtkBoostPanel
@onready var atk_boost_button: Button = $AtkBoostPanel/AtkBoostButton
@onready var reward_panel: Panel = $RewardPanel
@onready var reward_button: Button = $RewardPanel/RewardButton
@onready var map_panel: Panel = $MapPanel
@onready var map_button: Button = $MapPanel/MapButton
@onready var skip_button: Button = $SkipButton
@onready var background_1: Sprite2D = $Background1
@onready var background_2: Sprite2D = $Background2
@onready var background_3: Sprite2D = $Background3
@onready var background_4: Sprite2D = $Background4

func _ready():
	# disable all unused buttons
	# reenable and disable buttons with each press
	# toggle visibility with button presses
	# modify new game to go to tutorial
	# have tutorial end with getting a card
	# skip tutorial does not get a card
	start_button.disabled = false
	battle_button.disabled = true
	enemy_button.disabled = true
	player_button.disabled = true
	card_button.disabled = true
	reward_button.disabled = true
	map_button.disabled = true
	atk_boost_button.disabled = true


func _on_skip_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/world_map.tscn")


func _on_start_button_pressed() -> void:
	start_panel.visible = false
	start_button.disabled = true
	battle_panel.visible = true
	battle_button.disabled = false

func _on_battle_button_pressed() -> void:
	battle_panel.visible = false
	battle_button.disabled = true
	enemy_panel.visible = true
	enemy_button.disabled = false

func _on_enemy_button_pressed() -> void:
	enemy_panel.visible = false
	enemy_button.disabled = true
	player_panel.visible = true
	player_button.disabled = false
	

func _on_player_button_pressed() -> void:
	player_panel.visible = false
	player_button.disabled = true
	card_panel.visible = true
	card_button.disabled = false


func _on_card_button_pressed() -> void:
	card_panel.visible = false
	card_button.disabled = true
	background_1.visible = false
	background_4.visible = true
	atk_boost_panel.visible = true
	atk_boost_button.disabled = false


func _on_reward_button_pressed() -> void:
	reward_panel.visible = false
	reward_button.disabled = true
	background_2.visible = false
	background_3.visible = true
	map_panel.visible = true
	map_button.disabled = false


func _on_map_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Deck_Manager.tscn")


func _on_atk_boost_button_pressed() -> void:
	atk_boost_panel.visible = false
	atk_boost_button.disabled = true
	background_4.visible = false
	background_2.visible = true
	reward_panel.visible = true
	reward_button.disabled = false
