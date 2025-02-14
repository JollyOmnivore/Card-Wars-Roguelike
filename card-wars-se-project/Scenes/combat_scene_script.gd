extends Control

@onready var enemy_health_bar = $EnemyHealthBar
@onready var player_health_bar = $PlayerHealthBar
@onready var turn_indicator = $TurnIndicator
@onready var player_hand_container = $PlayerHandContainer
@onready var attackAnimation = $attackAnimation
func _ready():
	attackAnimation.visible = false
	print("Combat Scene Initialized")
	update_health_display()
	load_player_hand()
	update_turn_indicator()

func update_health_display():
	var game_manager = get_tree().root.get_node_or_null("GameManager")
	if game_manager:
		print("Updating health bars - Player:", game_manager.player_health, "Enemy:", game_manager.enemy_health)
		player_health_bar.value = game_manager.player_health
		enemy_health_bar.value = game_manager.enemy_health
	else:
		print("ERROR: GameManager not found!")

func load_player_hand():
	var game_manager = get_tree().root.get_node_or_null("GameManager")
	if game_manager and game_manager.PlayerHandScene:
		print("Loading Player Hand Scene")
		var player_hand_instance = game_manager.PlayerHandScene.instantiate()
		player_hand_container.add_child(player_hand_instance)
	else:
		print("ERROR: GameManager or PlayerHandScene not found!")

func update_turn_indicator():
	var game_manager = get_tree().root.get_node_or_null("GameManager")
	if game_manager:
		turn_indicator.text = "Player's Turn" if game_manager.player_turn else "Enemy's Turn"
		print("Turn Indicator Updated - Current Turn:", turn_indicator.text)
	else:
		print("ERROR: GameManager not found!")

#self explanitory but this will be for mthe turn indicator
func on_turn_change():
	print("on_turn_change() called")
	update_turn_indicator()
	
	
func playAttackAnimation():
	attackAnimation.visible = true
	attackAnimation.play('default')
	await attackAnimation.animation_finished
	attackAnimation.visible= false

	
	

	
	
