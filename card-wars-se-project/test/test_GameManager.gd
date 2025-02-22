extends GutTest

var GameManager = preload("res://Scripts/game_manager.gd")
var gameManager: GameManager

func before_each() -> void:
	gameManager = GameManager.new()
	add_child(gameManager)
	await get_tree().process_frame

func after_each() -> void:
	gameManager.queue_free()
	await get_tree().process_frame

func test_initial_state():
	assert_eq(gameManager.player_health, 100, "Player health should start at 100")
	assert_eq(gameManager.enemy_health, 100, "Enemy health should start at 100")
	assert_eq(gameManager.player_turn, true, "Player should start first")
	assert_eq(gameManager.player_def, 0, "Player defense should start at 0")

func test_player_attack():
	gameManager.player_action("attack")
	assert_eq(gameManager.enemy_health, 80, "Enemy should take 20 damage from attack")
	assert_eq(gameManager.player_turn, false, "Turn should switch after attack")

func test_player_heal():
	gameManager.player_health = 50
	gameManager.player_action("heal")
	assert_eq(gameManager.player_health, 65, "Player should heal for 15 HP")
	assert_eq(gameManager.player_turn, false, "Turn should switch after heal")

func test_player_defend():
	gameManager.player_action("defend")
	assert_eq(gameManager.player_def, 10, "Player defense should increase by 10")
	assert_eq(gameManager.player_turn, false, "Turn should switch after defend")

func test_enemy_turn_attack():
	gameManager.player_def = 0
	gameManager.enemy_turn()
	assert_true(gameManager.player_health <= 100 and gameManager.player_health >= 85, "Player should lose between 0 and 15 HP depending on defense")
	assert_eq(gameManager.player_turn, true, "Turn should switch back to player")

func test_enemy_turn_heal():
	gameManager.enemy_health = 50
	gameManager.enemy_turn()
	assert_true(gameManager.enemy_health >= 50 and gameManager.enemy_health <= 60, "Enemy should heal if it chooses to heal")

func test_victory_condition():
	gameManager.enemy_health = 20
	gameManager.player_action("attack")
	assert_true(gameManager.enemy_health <= 0, "Enemy should be defeated")
	assert_eq(gameManager.player_turn, false, "Game should end before switching turn")

func test_defeat_condition():
	gameManager.player_health = 10
	gameManager.player_def = 0
	gameManager.enemy_turn()
	assert_true(gameManager.player_health <= 0, "Player should be defeated")

func test_reset_game():
	gameManager.player_health = 50
	gameManager.enemy_health = 50
	gameManager.player_def = 5
	gameManager.player_turn = false
	gameManager.reset_game()
	assert_eq(gameManager.player_health, 100, "Player health should reset to 100")
	assert_eq(gameManager.enemy_health, 100, "Enemy health should reset to 100")
	assert_eq(gameManager.player_def, 0, "Player defense should reset to 0")
	assert_eq(gameManager.player_turn, true, "Player should start first after reset")
