extends Node

@export var CombatScene: PackedScene
@export var EnemyScene: PackedScene
@export var PlayerHandScene: PackedScene 

const PLAYER_MAX_HEALTH = 100 # subject to change in the future
const ENEMY_MAX_HEALTH = 100 # subject to change in the the future
var enemy_health: int = 100
var player_health: int = 100
var player_turn: bool = true
var player_def: int = 0
var card_types = ["attack", "heal", "defend"] 
var combat_instance = null  # Declare combat_instance globally
var enemy_next_action = 0


func _ready():
	print("Game Manager Initialized")
	start_combat()

func start_combat():
	print("Starting combat...")

	await get_tree().process_frame  # Let the scene process for 1 frame

	if CombatScene:
		print("Instantiating Combat Scene")
		combat_instance = CombatScene.instantiate()
		get_tree().root.add_child(combat_instance)  # Ensure it's added to root
		combat_instance.name = "CombatScene"  # Rename it for easy access

		print("Combat Scene Added! Name in Tree:", combat_instance.name)

	if PlayerHandScene and combat_instance:
		print("Instantiating Player Hand Scene inside CombatScene")
		var player_hand_instance = PlayerHandScene.instantiate()
		combat_instance.add_child(player_hand_instance)

	# Print all root nodes
	print("Root Nodes in Scene Tree AFTER CombatScene added:")
	for node in get_tree().root.get_children():
		print(" -", node.name)
		


func player_action(action: String):
	var combat_scene = get_tree().root.get_node_or_null("CombatScene")
	print("Player action triggered:", action)
	
	if not player_turn:
		print("Not player's turn, action ignored.")
		return

	match action:
		"attack":
			player_action_attack(20, combat_scene)
		"heal":
			player_action_heal(15, combat_scene)
		"defend":
			player_action_defend(10)

	if combat_scene:
		print("CombatScene found, updating UI")
		combat_scene.master_update()
	else:
		print("ERROR: CombatScene not found!")
	end_turn(combat_scene)

func player_action_attack(value: int, combat_scene: Node):
	if combat_scene:
		combat_scene.playAttackAnimation()  # Only call if combat_scene is valid
		print("Player attacks! Enemy Health:", enemy_health)
		await get_tree().create_timer(0.3).timeout # time to increase impact of attack effect causing damage
		enemy_health -= value
		combat_scene.master_update()
		print("Unit test check", enemy_health)

		if enemy_health <= 0:
			print("player wins. switch to victory scene")
			get_tree().change_scene_to_file("res://Scenes/combat_victory.tscn")
			return

func player_action_heal(value: int, combat_scene: Node):
	if player_health < PLAYER_MAX_HEALTH:
		player_health += value
	if player_health > PLAYER_MAX_HEALTH:
		player_health = PLAYER_MAX_HEALTH
	combat_scene.PlayerHealEffect()
	print("Player heals! Player Health:", player_health)

func player_action_defend(value: int):
	player_def = value
	print("Player defends! Player Defense:", player_def)


func enemy_turn():
	var combat_scene = get_tree().root.get_node_or_null("CombatScene")
	print("Enemy's turn started...")
	await get_tree().create_timer(0.75).timeout 
	
	if (not combat_scene):
		print("ERROR: CombatScene not found!")
		return
	#var enemy_action = randi() % 2 #old attack action 
	var enemy_action = enemy_next_action
	enemy_next_action = randi() % 2
	combat_scene.updateEnemyNextMoveIndicator(enemy_next_action)
	
	print("Enemy chose action:", enemy_action)

	# attack for 15, heal for 10
	enemy_action_exectute(enemy_action, 15 if enemy_action == 0 else 10, combat_scene)

	player_def = 0

	if combat_scene:
		print("Updating Combat Scene UI after enemy turn")
		combat_scene.master_update()
	else:
		print("ERROR: CombatScene not found!")

	end_turn(combat_scene)

func enemy_action_exectute(action: int, value: int, combat_scene: Node):
	if action == 0:
		var damage = max(0, value - player_def) 
		player_health -= damage
		combat_scene.PlayerTakeDamage()
		print("Enemy attacks! Player Health:", player_health)

		if player_health <= 0:
			print("Enemy wins. Switching to game over.")
			get_tree().change_scene_to_file("res://Scenes/combat_defeat.tscn")
			return

	elif action == 1:
		combat_scene.playEnemyHealAnimation() 
		if enemy_health < ENEMY_MAX_HEALTH:
			enemy_health += value
		if enemy_health > ENEMY_MAX_HEALTH:
			enemy_health = ENEMY_MAX_HEALTH
		print("Enemy heals! Enemy Health:", enemy_health)

	else:
		print("Unknown Enemy Action Error")


# Ends the turn and switches between player and enemy 
func end_turn(combat_scene: Node):
	print("Ending turn. Player's turn before toggle:", player_turn)
	player_turn = !player_turn  # Toggle turn
	if combat_scene:
		combat_scene.master_update()
	if not player_turn:
		print("Waiting for enemy's turn")
		await get_tree().create_timer(0.75).timeout 
		enemy_turn()






# Resets the game, for debugging later down the line
func reset_game():
	print("Resetting game...")
	player_health = 100
	enemy_health = 100
	player_def = 0
	player_turn = true
	print("Game Reset - Player Health:", player_health, "Enemy Health:", enemy_health)
