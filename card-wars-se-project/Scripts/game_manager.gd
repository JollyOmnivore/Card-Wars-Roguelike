extends Node


@export var CombatScene: PackedScene
@export var EnemyScene: PackedScene
@export var PlayerHandScene: PackedScene 
@export var WorldMap: PackedScene

const PLAYER_MAX_HEALTH = 100
const ENEMY_MAX_HEALTH = 30
#const ENEMY_BOSS_MAX_HEALTH = 250
const ENEMY_ACTIONS = [ENEMY_ACTION_ATTACK, ENEMY_ACTION_ATTACK, ENEMY_ACTION_ATTACK, ENEMY_ACTION_HEAL, ENEMY_ACTION_HEAL]
const ENEMY_ACTION_ATTACK = 0
const ENEMY_ACTION_HEAL = 1
const ENEMY_ATTACK_BASE = 2.8
const ENEMY_HEAL_BASE = 1.6
var enemy_action_repeat = 0
var enemy_health: int = 100
var player_health: int = 100
var player_turn: bool = true
var player_def: int = 0
var current_atk_boost = 0
var card_types = ["attack", "heal", "defend"] 
var combat_instance = null  # Declare combat_instance globally
var enemy_next_action = ENEMY_ACTION_ATTACK
var enemy_action = ENEMY_ACTION_ATTACK
var map_progression = 1
var difficulty_multiplier = .75
var enemy_health_comparator = 0
var Player_Deck = ["Attack 7", "Defend 7", "Attack 7", "Attack 7", "Attack 7", "Defend 7", "Attack 7", "Heal 5"]
var worldPathA = []
var worldPathB= []
var EnemyIsElite = false

func _ready():
	print("Game Manager Initialized")
	start_combat()
	generate_world_Map()
	print("WORLD MAP")
	print(worldPathA)
	print(worldPathB)
	
func generate_world_Map():
	var POIs = ["Enemy", "Elite", "Campfire","Enemy","Enemy"]
	for i in range(0,5):
		worldPathA.append(POIs.pick_random())
		worldPathB.append(POIs.pick_random())
		if worldPathA[i] == worldPathB[i] || worldPathA[i] != "Enemy":
			var random_value = randf()
			if random_value == 0:
				worldPathA[i] = "Enemy"
			else:
				worldPathB[i] = "Enemy"
			
		
	

func start_combat():
	print("Player Deck Below")
	print(Player_Deck)
	enemy_health_comparator = (ENEMY_MAX_HEALTH + 3 * (map_progression - 2)) * difficulty_multiplier
	print(enemy_health_comparator)
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
		

func player_action(action: String, value: int):
	if player_health <= 0:
		print("Enemy wins. Switching to game over.")
		get_tree().change_scene_to_file("res://Scenes/combat_defeat.tscn")
		return
		
	var combat_scene = get_tree().root.get_node_or_null("CombatScene")
	print("Player action:", action, " with value:", value)
	
	if not player_turn:
		print("Not player's turn")
		return

	match action:
		"attack":
			player_action_attack(value, combat_scene)
		"heal":
			player_action_heal(value, combat_scene)
		"defend":
			player_action_defend(value, combat_scene)
		"atkboost":
			current_atk_boost += value

	if combat_scene:
		combat_scene.master_update()
	else:
		print("ERROR: CombatScene not found!")
	end_turn(combat_scene)


func player_action_attack(value: int, combat_scene: Node):
	if combat_scene:
		combat_scene.playAttackAnimation()  # Only call if combat_scene is valid
		print("Player attacks! Enemy Health:", enemy_health)
		await get_tree().create_timer(0.3).timeout # time to increase impact of attack effect causing damage
		enemy_health -= (value + current_atk_boost)
		combat_scene.master_update()
		print("Unit test check", enemy_health)

func player_action_heal(value: int, combat_scene: Node):
	if player_health < PLAYER_MAX_HEALTH:
		player_health += value
	if player_health > PLAYER_MAX_HEALTH:
		player_health = PLAYER_MAX_HEALTH
	combat_scene.PlayerHealEffect()
	print("Player heals! Player Health:", player_health)

func player_action_defend(value: int, combat_scene: Node):
	combat_scene.SheildFlickerAnimation()
	player_def = value
	print("Player defends! Player Defense:", player_def)




func enemy_turn():
	if enemy_health <= 0:
			print("player wins. switch to victory scene")
			#get_tree().root.get_node_or_null("PlayerHandScene").free()
			if (map_progression < 8):
				get_tree().change_scene_to_file("res://Scenes/Deck_Manager.tscn")
			elif (map_progression >= 8):
				get_tree().change_scene_to_file("res://Scenes/combat_victory.tscn")
			#PlayerHandScene.free()
			return
	var combat_scene = get_tree().root.get_node_or_null("CombatScene")
	print("Enemy's turn started...")
	await get_tree().create_timer(0.75).timeout 
	
	if (not combat_scene):
		print("ERROR: CombatScene not found!")
		return
	enemy_action = enemy_next_action
	enemy_next_action = enemy_action_choose()

	combat_scene.updateEnemyNextMoveIndicator(enemy_next_action)
	
	print("Enemy current action:", enemy_action)
	print("Enemy next action:", enemy_next_action)

	enemy_action_execute(enemy_action, (ENEMY_ATTACK_BASE + map_progression) * difficulty_multiplier if enemy_action == ENEMY_ACTION_ATTACK else (ENEMY_HEAL_BASE + map_progression) * difficulty_multiplier, combat_scene)

	player_def = 0

	if combat_scene:
		print("Updating Combat Scene UI after enemy turn")
		combat_scene.master_update()
	else:
		print("ERROR: CombatScene not found!")

	end_turn(combat_scene)

func enemy_action_choose() -> int:
	var next = ENEMY_ACTIONS.pick_random()
	enemy_health_comparator = (ENEMY_MAX_HEALTH + 3 * (map_progression - 2)) * difficulty_multiplier

	if enemy_health >= enemy_health_comparator:
		enemy_action_repeat += 1
		print("Enemy is full health. Force attack.")
		return ENEMY_ACTION_ATTACK

	if enemy_action == next:
		enemy_action_repeat += 1
	else:
		enemy_action_repeat = 0

	if enemy_action_repeat == 1 and next == ENEMY_ACTION_HEAL:
		enemy_action_repeat = 0
		return ENEMY_ACTION_ATTACK

	if enemy_action_repeat > 2 and next == ENEMY_ACTION_ATTACK:
		enemy_action_repeat = 0
		return ENEMY_ACTION_HEAL

	return next


func enemy_action_execute(action: int, value: int, combat_scene: Node):
	if action == ENEMY_ACTION_ATTACK:
		if player_def > 0:
			combat_scene.sheildBlockAnimation()
		if EnemyIsElite== true:
			var damage = max(0, value*1.6 - player_def) # This handles the damage buff for elite enemys
			player_health -= damage
		else:
			var damage = max(0, value - player_def)
			player_health -= damage
		combat_scene.PlayerTakeDamage()
		if player_health <= 0:
			await get_tree().create_timer(0.3).timeout
			get_tree().change_scene_to_file("res://Scenes/combat_defeat.tscn")
		print("Enemy attacks! Player Health:", player_health)
	elif action == ENEMY_ACTION_HEAL:
		combat_scene.playEnemyHealAnimation()
		if map_progression >= 8:
			if enemy_health < enemy_health_comparator:
				enemy_health += value
			if enemy_health > enemy_health_comparator:
				enemy_health = enemy_health_comparator
		else:
			if enemy_health < enemy_health_comparator:
				enemy_health += value
			if enemy_health > enemy_health_comparator:
				enemy_health = enemy_health_comparator
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
func reset_combat():
	print("Resetting combat...")
	#if player_health <= 50:
	#	difficulty_multiplier = 0.8
	if map_progression >= 8:
		difficulty_multiplier *= 1.4

	enemy_health = (ENEMY_MAX_HEALTH + 3 * (map_progression - 2)) * difficulty_multiplier

		
	player_def = 0
	current_atk_boost = 0
	player_turn = true
	print("Game Reset - Player Health:", player_health, "Enemy Health:", enemy_health)
