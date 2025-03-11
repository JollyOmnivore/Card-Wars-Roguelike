extends Node

@export var CombatScene: PackedScene

var player_health: int = 100
var player_max_health: int = 100

func _ready():
	print("Game Manager Initialized")
	start_combat()

func start_combat():
	print("Starting combat...")
	var combat_instance = null

	await get_tree().process_frame  # Let the scene process for 1 frame

	if CombatScene:
		print("Instantiating Combat Scene")
		combat_instance = CombatScene.instantiate()
		get_tree().root.add_child(combat_instance)  # Ensure it's added to root
		combat_instance.name = "CombatScene"  # Rename it for easy access
		print("Combat Scene Added! Name in Tree:", combat_instance.name)

	# Print all root nodes
	print("Root Nodes in Scene Tree AFTER CombatScene added:")
	for node in get_tree().root.get_children():
		print(" -", node.name)

func end_combat():
	print("Ending combat...")
	var combat_instance = get_tree().root.get_node_or_null("CombatScene")
	if combat_instance:
		combat_instance.queue_free()
		print("Combat Scene removed from tree")
	else:
		print("ERROR: CombatScene not found!")

func get_player_health() -> int:
	return player_health
func set_player_health(health: int):
	player_health = health
	if player_health <= 0:
		print("Player health is 0. Switching to game over.")
		get_tree().change_scene_to_file("res://Scenes/combat_defeat.tscn")
func get_player_max_health() -> int:
	return player_max_health
func set_player_max_health(health: int):
	player_max_health = health

# Resets the game, for debugging later down the line
func reset_game():
	print("Resetting game...")
	end_combat()
	set_player_health(100)
