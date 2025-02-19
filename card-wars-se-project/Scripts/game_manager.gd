extends Node

@export var CombatScene: PackedScene
@export var EnemyScene: PackedScene
@export var PlayerHandScene: PackedScene 

var enemy_health: int = 100
var player_health: int = 100
var player_turn: bool = true
var card_types = ["attack", "heal", "defend"] 
var combat_instance = null  # Declare combat_instance globally

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

	# Print all root nodes to confirm CombatScene exists
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
			enemy_health -= 20
			combat_scene.playAttackAnimation()#plays animation in combat scene
			print("Player attacks! Enemy Health:", enemy_health)
			if enemy_health <= 0:
				print("player wins. switch to victory scene")
				get_tree().change_scene_to_file("res://Scenes/combat_victory.tscn")
				return
		"heal":
			player_health += 15
			print("Player heals! Player Health:", player_health)
		"defend":
			print("Player defends!") # defending does nothing yet

	# DEBUGGING Check if CombatScene exists
	
	if combat_scene:
		print("CombatScene found, updating UI")
		combat_scene.update_health_display()
		combat_scene.on_turn_change()
		
	else:
		print("ERROR: CombatScene not found!")

	end_turn()

# Handles enemy's turn
func enemy_turn():
	print("Enemy's turn started...")
	var enemy_action = randi() % 2  #Simple AI: 0 = attack, 1 = heal. I told you this would be easier Logan
	print("Enemy chose action:", enemy_action)
	
	if enemy_action == 0:
		player_health -= 15
		print("Enemy attacks! Player Health:", player_health)
		if player_health <= 0:
			print("enemy wins. switch to game over")
			get_tree().change_scene_to_file("res://Scenes/combat_defeat.tscn")
			return
	else:
		enemy_health += 10
		print("Enemy heals! Enemy Health:", enemy_health)

	# Update Combat Scene UI
	var combat_scene = get_tree().root.get_node_or_null("CombatScene")
	if combat_scene:
		print("Updating Combat Scene UI after enemy turn")
		combat_scene.update_health_display()
		combat_scene.on_turn_change()
	else:
		print("ERROR: CombatScene not found!")

	end_turn()

# Ends the turn and switches between player and enemy 
func end_turn():
	print("Ending turn. Player's turn:", player_turn)
	player_turn = !player_turn
	if not player_turn:
		print("Waiting for enemy's turn...")
		await get_tree().create_timer(1.0).timeout
		enemy_turn()

# Resets the game, for debugging later down the line
func reset_game():
	print("Resetting game...")
	player_health = 100
	enemy_health = 100
	player_turn = true
	print("Game Reset - Player Health:", player_health, "Enemy Health:", enemy_health)
