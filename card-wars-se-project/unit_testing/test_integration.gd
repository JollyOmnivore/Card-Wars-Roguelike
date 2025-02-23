extends GutTest


var GameManager = preload("res://Scripts/game_manager.gd")
var CombatScene = preload("res://Scenes/combat_scene_script.gd")
var PlayerHandScene = preload("res://Scenes/player_hand_scene.gd")

var gameManager: GameManager # its is own type now since idk 
var combatScene: Node  # Use Node since CombatScene is a script 
var playerHandScene: Node  # Use Node since PlayerHandScene is a script

func before_each() -> void:
	gameManager = GameManager.new()
	var combat_scene_packed = load("res://Scenes/CombatScene.tscn")
	combatScene = combat_scene_packed.instantiate()
	var player_hand_scene_packed = load("res://Scenes/PlayerHand Scene.tscn") 
	playerHandScene = player_hand_scene_packed.instantiate()
	add_child(gameManager)
	add_child(combatScene)
	add_child(playerHandScene)
	await get_tree().process_frame 



func after_each() -> void:
	gameManager.queue_free()
	combatScene.queue_free()
	playerHandScene.queue_free()
	await get_tree().process_frame 

# TEST 1: Clicking Attack Button Signals GM
func test_attack_button_triggers_game_manager():
	var initial_enemy_health = gameManager.enemy_health
	gameManager.player_action("attack")
	await get_tree().process_frame  # Allow time for processing
	print("DEBUG: Enemy health after attack:", gameManager.enemy_health)
	print("DEBUG: Player turn after attack:", gameManager.player_turn)
	assert_true(gameManager.enemy_health < initial_enemy_health, "Enemy should lose health when attack button is clicked")
	assert_eq(gameManager.player_turn, false, "Turn should switch after attack")



# Integration Test 2 Attack Action Triggers Animation in CombatScene
func test_attack_triggers_animation():
	gameManager.player_action("attack")
	await get_tree().process_frame  # Allow animation triggerode
	var attack_anim = combatScene.get_node_or_null("attackAnimation")
	assert_not_null(attack_anim, "attackAnimation node should exist in CombatScene")
	await attack_anim.animation_finished # didnt have this before and was casuing fails due to a quick visiblity switch
	assert_true(attack_anim.visible, "Attack animation should be visible during attack") 
