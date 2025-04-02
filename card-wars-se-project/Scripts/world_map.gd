extends Control
@onready var node_start: Button = $node_start
@onready var node_enemy_1: Button = $node_enemy1
@onready var node_enemy_2: Button = $node_enemy2

func _ready() -> void:
	match GameManager.map_progression:
		0:
			node_enemy_1.disabled = false
			node_enemy_2.disabled = true
			node_start.disabled = true
		1:
			node_enemy_1.disabled = true
			node_enemy_2.disabled = false
			node_start.disabled = true
		2:
			node_enemy_1.disabled = true
			node_enemy_2.disabled = true
			node_start.disabled = true

func _on_node_enemy_1_pressed() -> void:
	GameManager.map_progression += 1
	GameManager.reset_combat()
	GameManager.start_combat()
	get_tree().change_scene_to_file("res://Scenes/CombatScene.tscn")


func _on_node_enemy_2_pressed() -> void:
	GameManager.map_progression += 1
	GameManager.reset_combat()
	GameManager.start_combat()
	get_tree().change_scene_to_file("res://Scenes/CombatScene.tscn")
