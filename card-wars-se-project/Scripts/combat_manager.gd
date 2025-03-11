extends Node

const PLAYER_MAX_HEALTH = 100 # subject to change in the future
const ENEMY_MAX_HEALTH = 100 # subject to change in the the future
var enemy_health: int = 100
var player_def: int = 0
var card_types = ["attack", "heal", "defend"]
var player_turn: bool = true

func player_action(action: String, value: int):
	var combat_scene = get_tree().root.get_node_or_null("CombatScene")
	print("Player action triggered:", action)
	
	if not player_turn:
		print("Not player's turn, action ignored.")
		return

	match action:
		"attack":
			if combat_scene:
				combat_scene.playAttackAnimation()
			player_attack(value)
		"heal":
			player_heal(value)
		"defend":
			player_def += 10
			print("Player defends!")

	if combat_scene:
		print("CombatScene found, updating UI")
		combat_scene.master_update()
	else:
		print("ERROR: CombatScene not found!")

	end_turn()

func player_attack(damage: int):
	enemy_health -= damage  # Use the damage parameter instead of a fixed value
	print("Unit test check", enemy_health)
	print("Player attacks! Enemy Health:", enemy_health)
	if enemy_health <= 0:
		print("player wins. switch to victory scene")
		get_tree().change_scene_to_file("res://Scenes/combat_victory.tscn")
		return
	
func player_heal(heal: int):
	var game_manager = get_tree().root.get_node_or_null("GameManager")
	if game_manager:
		var player_health = game_manager.get_player_health()
		var player_max_health = game_manager.get_player_max_health()
		if player_health < player_max_health:
			player_health += heal 
		if player_health > player_max_health:
			player_health = player_max_health
		game_manager.set_player_health(player_health)
		print("Player heals! Player Health:", game_manager.get_player_health())
	else:
		print("ERROR: GameManager not found!")


func enemy_turn():
	print("Enemy's turn started...")
	await get_tree().create_timer(0.75).timeout 
	var enemy_action = randi() % 2
	print("Enemy chose action:", enemy_action)

	if enemy_action == 0:
		var damage = max(0, 15 - player_def)
		var game_manager = get_tree().root.get_node_or_null("GameManager")
		var player_health = game_manager.get_player_health()
		game_manager.set_player_health(player_health - damage)  # Update player health in GameManager
		print("Enemy attacks! Player Health:", game_manager.get_player_health())  # Print updated health

	elif enemy_action == 1:
		if enemy_health < ENEMY_MAX_HEALTH:
			enemy_health += 10
		if enemy_health > ENEMY_MAX_HEALTH:
			enemy_health = ENEMY_MAX_HEALTH
		print("Enemy heals! Enemy Health:", enemy_health)

	else:
		print("Unknown Enemy Action Error")

	player_def = 0

	var combat_scene = get_tree().root.get_node_or_null("CombatScene")
	if combat_scene:
		print("Updating Combat Scene UI after enemy turn")
		combat_scene.update_health_display()
		combat_scene.update_defense_display()
		combat_scene.on_turn_change()
	else:
		print("ERROR: CombatScene not found!")


	end_turn()


# Ends the turn and switches between player and enemy 
func end_turn():
	print("Ending turn. Player's turn before toggle:", player_turn)
	player_turn = !player_turn  # Toggle turn
	var combat_scene = get_tree().root.get_node_or_null("CombatScene")
	if combat_scene:
		combat_scene.on_turn_change()
		combat_scene.master_update()
	if not player_turn:
		print("Waiting for enemy's turn")
		await get_tree().create_timer(0.75).timeout 
		enemy_turn()
