extends Control
@onready var node_start: Button = $node_start

@onready var node_enemy_2: Button = $node_enemy2
@onready var tier_1_node_enemy_1: Button = $tier_1_node_enemy1
@onready var tier_2_node_enemy_2: Button = $tier_2_node_enemy2
@onready var tier_2_node_enemy_3: Button = $tier_2_node_enemy3
@onready var tier_3_node_enemy_4: Button = $tier_3_node_enemy4
@onready var tier_3_node_enemy_5: Button = $tier_3_node_enemy5
@onready var tier_4_node_enemy_8: Button = $tier_4_node_enemy8
@onready var tier_4_node_enemy_7: Button = $tier_4_node_enemy7
@onready var tier_5_node_boss: Button = $tier_5_node_boss
@onready var progression_indicator: Label = $"Progression Indicator"
@onready var texture_enemy_health_bar: TextureProgressBar = $map_background/TextureEnemyHealthBar


func _ready() -> void:
	var healthLabelInt = GameManager.player_health
	texture_enemy_health_bar.value = float(healthLabelInt)
	var labelprogress = GameManager.map_progression
	progression_indicator.text = str(labelprogress)
	match GameManager.map_progression:
		1:

			node_start.disabled = true
			tier_2_node_enemy_2.disabled = true
			tier_2_node_enemy_3.disabled = true
			tier_3_node_enemy_4.disabled = true
			tier_3_node_enemy_5.disabled = true
			tier_4_node_enemy_8.disabled = true
			tier_4_node_enemy_7.disabled = true
			tier_5_node_boss.disabled = true
			#enabled
			tier_1_node_enemy_1.disabled = false
		2:
			tier_1_node_enemy_1.disabled = true
			tier_3_node_enemy_4.disabled = true
			tier_3_node_enemy_5.disabled = true
			node_start.disabled = true
			tier_4_node_enemy_8.disabled = true
			tier_4_node_enemy_7.disabled = true
			tier_5_node_boss.disabled = true
			#enabled
			tier_2_node_enemy_3.disabled = false
			tier_2_node_enemy_2.disabled = false
		3:
			tier_1_node_enemy_1.disabled = true
			tier_2_node_enemy_2.disabled = true
			tier_2_node_enemy_3.disabled = true
			node_start.disabled = true
			tier_4_node_enemy_8.disabled = true
			tier_4_node_enemy_7.disabled = true
			tier_5_node_boss.disabled = true
			#enabled
			tier_3_node_enemy_4.disabled = false
			tier_3_node_enemy_5.disabled = false
		4:
			tier_1_node_enemy_1.disabled = true
			tier_2_node_enemy_2.disabled = true
			tier_2_node_enemy_3.disabled = true
			node_start.disabled = true
			tier_3_node_enemy_4.disabled = true
			tier_3_node_enemy_5.disabled = true
			tier_5_node_boss.disabled = true
			#enabled
			tier_4_node_enemy_8.disabled = false
			tier_4_node_enemy_7.disabled = false
		5:
			tier_1_node_enemy_1.disabled = true
			node_start.disabled = true
			tier_2_node_enemy_2.disabled = true
			tier_2_node_enemy_3.disabled = true
			tier_3_node_enemy_4.disabled = true
			tier_3_node_enemy_5.disabled = true
			tier_4_node_enemy_8.disabled = true
			tier_4_node_enemy_7.disabled = true
			#enabled 
			tier_5_node_boss.disabled = false
			


func _on_tier_1_node_enemy_1_pressed() -> void:
	GameManager.map_progression += 1
	GameManager.reset_combat()
	GameManager.start_combat()
	get_tree().change_scene_to_file("res://Scenes/CombatScene.tscn")

#tier 2 
func _on_tier_2_node_enemy_2_pressed() -> void:
	GameManager.map_progression += 1
	GameManager.reset_combat()
	GameManager.start_combat()
	get_tree().change_scene_to_file("res://Scenes/CombatScene.tscn")

func _on_tier_2_node_enemy_3_pressed() -> void:
	GameManager.map_progression += 1
	GameManager.reset_combat()
	GameManager.start_combat()
	get_tree().change_scene_to_file("res://Scenes/CombatScene.tscn")

#tier 3

func _on_tier_3_node_enemy_4_pressed() -> void:
	GameManager.map_progression += 1
	GameManager.reset_combat()
	GameManager.start_combat()
	get_tree().change_scene_to_file("res://Scenes/CombatScene.tscn")


func _on_tier_3_node_enemy_5_pressed() -> void:
	GameManager.map_progression += 1
	GameManager.reset_combat()
	GameManager.start_combat()
	get_tree().change_scene_to_file("res://Scenes/CombatScene.tscn")

#tier 4

func _on_tier_4_node_enemy_8_pressed() -> void:
	GameManager.map_progression += 1
	GameManager.reset_combat()
	GameManager.start_combat()
	get_tree().change_scene_to_file("res://Scenes/CombatScene.tscn")
	
func _on_tier_4_node_enemy_7_pressed() -> void:
	GameManager.map_progression += 1
	GameManager.reset_combat()
	GameManager.start_combat()
	get_tree().change_scene_to_file("res://Scenes/CombatScene.tscn")

#tier 5 / Boss

func _on_tier_5_node_boss_pressed() -> void:
	GameManager.map_progression += 1
	GameManager.reset_combat()
	GameManager.start_combat()
	get_tree().change_scene_to_file("res://Scenes/CombatScene.tscn")
