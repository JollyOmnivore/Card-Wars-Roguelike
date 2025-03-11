extends Control

@export var EnemyScene: PackedScene
@export var PlayerHandScene: PackedScene
@export var CombatManager: PackedScene

@onready var enemy_health_bar = $EnemyHealthBar
@onready var player_health_bar = $PlayerHealthBar
@onready var turn_indicator = $TurnIndicator
@onready var player_hand_container = $PlayerHandContainer
@onready var attackAnimation = $attackAnimation
@onready var player_def: Label = $PlayerDef
@onready var combat_manager: Node = $CombatManager

func _ready():
	var combat_instance = get_tree().root.get_node_or_null("CombatScene")
	if CombatManager:
		combat_manager = CombatManager.instantiate()
		get_tree().root.add_child(combat_manager)
		combat_manager.name = "CombatManager"
		print("Combat Manager Added! Name in Tree:", combat_manager.name)
		# current result:
			# combat_manager = not null
			# CombatManager = null
			# ??????????????????????????????
	else:
		print("ERROR: CombatManager not found!")
	attackAnimation.visible = false
	print("Combat Scene Initialized")
	master_update()
	load_player_hand()
	if PlayerHandScene and combat_instance:
		print("Instantiating Player Hand Scene inside CombatScene")
		var player_hand_instance = PlayerHandScene.instantiate()
		combat_instance.add_child(player_hand_instance)
	# Ensure player hand is loaded before the combat starts
	if player_hand_container.get_child_count() == 0:
		print("ERROR: Player hand is empty!")
func master_update():
	update_health_display()
	update_defense_display()
	update_turn_indicator()

func update_health_display():
	var game_manager = get_tree().root.get_node_or_null("GameManager")
	if game_manager and combat_manager:
		print("Updating health bars - Player:", game_manager.get_player_health(), "Enemy:", combat_manager.enemy_health)
		player_health_bar.value = game_manager.get_player_health()
		enemy_health_bar.value = combat_manager.enemy_health
	else:
		print("ERROR: GameManager not found!")

func load_player_hand():
	print("Loading Player Hand Scene")
	var player_hand_instance = PlayerHandScene.instantiate()
	player_hand_container.add_child(player_hand_instance)
func update_turn_indicator():
	turn_indicator.text = "Player's Turn" if combat_manager.player_turn else "Enemy's Turn"
	print("Turn Indicator Updated - Current Turn:", turn_indicator.text)

#self explanitory but this will be for the turn indicator
func on_turn_change():
	print("on_turn_change() called")
	update_turn_indicator()
	
	
func playAttackAnimation():
	attackAnimation.visible = true
	attackAnimation.play('default')
	await attackAnimation.animation_finished
	attackAnimation.visible= false

func update_defense_display():
	if combat_manager:
		player_def.text = "Defense: " + str(combat_manager.player_def)
		print("Defense Display Updated - Defense:", combat_manager.player_def)
	else:
		print("ERROR: CombatManager not found!")
