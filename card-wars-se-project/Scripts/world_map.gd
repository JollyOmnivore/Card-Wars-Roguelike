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
@onready var tier_5_node_enemy_9: Button = $tier_5_node_enemy9
@onready var tier_5_node_enemy_10: Button = $tier_5_node_enemy10
@onready var tier_6_node_enemy_11: Button = $tier_6_node_enemy11
@onready var tier_6_node_enemy_12: Button = $tier_6_node_enemy12
@onready var tier_7_node_boss: Button = $tier_7_node_boss
@onready var player_health_number_label: Label = $PlayerHealthNumberLabel

@onready var heal_overlay: Sprite2D = $HealOverlay



@onready var progression_indicator: Label = $"Progression Indicator"
@onready var texture_enemy_health_bar: TextureProgressBar = $map_background/TextureEnemyHealthBar
@onready var camp_1: Button = $Camp1
@onready var camp_2: Button = $Camp2


func _ready() -> void:
	var healthLabelInt = GameManager.player_health
	texture_enemy_health_bar.value = float(healthLabelInt)
	player_health_number_label.text = str(healthLabelInt)+"/100"
	var labelprogress = GameManager.map_progression
	progression_indicator.text = str(labelprogress)
	loadWorldData()
	match GameManager.map_progression:
		1:

			node_start.disabled = true
			tier_2_node_enemy_2.disabled = true
			tier_2_node_enemy_3.disabled = true
			tier_3_node_enemy_4.disabled = true
			tier_3_node_enemy_5.disabled = true
			tier_4_node_enemy_8.disabled = true
			tier_4_node_enemy_7.disabled = true
			tier_5_node_enemy_9.disabled = true
			tier_5_node_enemy_9.disabled = true
			tier_5_node_enemy_10.disabled = true
			tier_6_node_enemy_11.disabled = true
			tier_6_node_enemy_12.disabled = true
			tier_7_node_boss.disabled = true
			camp_1.disabled = true	
			camp_2.disabled = true	
			#enabled
			tier_1_node_enemy_1.disabled = false
		2:
			tier_1_node_enemy_1.disabled = true
			tier_3_node_enemy_4.disabled = true
			tier_3_node_enemy_5.disabled = true
			node_start.disabled = true
			tier_4_node_enemy_8.disabled = true
			tier_4_node_enemy_7.disabled = true
			tier_5_node_enemy_9.disabled = true
			tier_5_node_enemy_10.disabled = true
			tier_6_node_enemy_11.disabled = true
			tier_6_node_enemy_12.disabled = true
			tier_7_node_boss.disabled = true
			camp_2.disabled = true	
			#enabled
			tier_2_node_enemy_3.disabled = false
			tier_2_node_enemy_2.disabled = false
			camp_1.disabled = false	
		3:
			tier_1_node_enemy_1.disabled = true
			tier_2_node_enemy_2.disabled = true
			tier_2_node_enemy_3.disabled = true
			node_start.disabled = true
			tier_4_node_enemy_8.disabled = true
			tier_4_node_enemy_7.disabled = true
			tier_5_node_enemy_9.disabled = true
			tier_5_node_enemy_10.disabled = true
			tier_6_node_enemy_11.disabled = true
			tier_6_node_enemy_12.disabled = true
			tier_7_node_boss.disabled = true
			camp_1.disabled = true	
			camp_2.disabled = true	
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
			tier_5_node_enemy_9.disabled = true
			tier_5_node_enemy_10.disabled = true
			camp_1.disabled = true	
			tier_6_node_enemy_11.disabled = true
			tier_6_node_enemy_12.disabled = true
			tier_7_node_boss.disabled = true
			#enabled
			tier_4_node_enemy_8.disabled = false
			tier_4_node_enemy_7.disabled = false
			camp_2.disabled = false	
			
		5:
			tier_1_node_enemy_1.disabled = true
			node_start.disabled = true
			tier_2_node_enemy_2.disabled = true
			tier_2_node_enemy_3.disabled = true
			tier_3_node_enemy_4.disabled = true
			tier_3_node_enemy_5.disabled = true
			tier_4_node_enemy_8.disabled = true
			tier_4_node_enemy_7.disabled = true
			tier_5_node_enemy_9.disabled = true
			tier_5_node_enemy_10.disabled = true
			tier_6_node_enemy_11.disabled = true
			tier_6_node_enemy_12.disabled = true
			tier_7_node_boss.disabled = true
			camp_1.disabled = true	
			camp_2.disabled = true	
			#enabled 
			tier_5_node_enemy_9.disabled = false	
			tier_5_node_enemy_10.disabled = false
		6:
			#enabled
			tier_6_node_enemy_11.disabled = false
			tier_6_node_enemy_12.disabled = false
			#disabled
			tier_7_node_boss.disabled = true
			tier_1_node_enemy_1.disabled = true
			node_start.disabled = true
			tier_2_node_enemy_2.disabled = true
			tier_2_node_enemy_3.disabled = true
			tier_3_node_enemy_4.disabled = true
			tier_3_node_enemy_5.disabled = true
			tier_4_node_enemy_8.disabled = true
			tier_4_node_enemy_7.disabled = true
			tier_5_node_enemy_9.disabled = true
			tier_5_node_enemy_10.disabled = true
			camp_1.disabled = true	
			camp_2.disabled = true	
		7: 
			#enebeled
			tier_7_node_boss.disabled = false
			#disabled
			tier_1_node_enemy_1.disabled = true
			node_start.disabled = true
			tier_2_node_enemy_2.disabled = true
			tier_2_node_enemy_3.disabled = true
			tier_3_node_enemy_4.disabled = true
			tier_3_node_enemy_5.disabled = true
			tier_4_node_enemy_8.disabled = true
			tier_4_node_enemy_7.disabled = true
			tier_5_node_enemy_9.disabled = true
			tier_5_node_enemy_10.disabled = true
			tier_6_node_enemy_11.disabled = true
			tier_6_node_enemy_12.disabled = true
			camp_1.disabled = true	
			camp_2.disabled = true	


func PlayerHealEffect():
	heal_overlay.modulate.a8 = 90
	await get_tree().create_timer(0.9).timeout 
	heal_overlay.modulate.a8 = 0





#starting enemy
func _on_tier_1_node_enemy_1_pressed() -> void:
	GameManager.map_progression += 1
	GameManager.reset_combat()
	GameManager.start_combat()
	get_tree().change_scene_to_file("res://Scenes/CombatScene.tscn")



#tier 2 
func _on_tier_2_node_enemy_2_pressed() -> void:
	MapNodePressed(tier_2_node_enemy_2.text)

func _on_tier_2_node_enemy_3_pressed() -> void:
	MapNodePressed(tier_2_node_enemy_3.text)

#tier 3

func _on_tier_3_node_enemy_4_pressed() -> void:
	MapNodePressed(tier_3_node_enemy_4.text)


func _on_tier_3_node_enemy_5_pressed() -> void:
	MapNodePressed(tier_3_node_enemy_5.text)

#tier 4

func _on_tier_4_node_enemy_8_pressed() -> void:
	MapNodePressed(tier_4_node_enemy_8.text)
	
func _on_tier_4_node_enemy_7_pressed() -> void:
	MapNodePressed(tier_4_node_enemy_7.text)


#tier 5

func _on_tier_5_node_enemy_10_pressed() -> void:
	MapNodePressed(tier_5_node_enemy_10.text)

func _on_tier_5_node_enemy_9_pressed() -> void:
	MapNodePressed(tier_5_node_enemy_9.text)


#tier 6

func _on_tier_6_node_enemy_11_pressed() -> void:
	MapNodePressed(tier_6_node_enemy_11.text)


func _on_tier_6_node_enemy_12_pressed() -> void:
	MapNodePressed(tier_6_node_enemy_12.text)


#tier 7 Boss

func _on_tier_7_node_boss_pressed() -> void:
	GameManager.EnemyIsElite = false
	GameManager.map_progression += 1
	GameManager.reset_combat()
	GameManager.start_combat()
	get_tree().change_scene_to_file("res://Scenes/CombatScene.tscn")


#load world map data
func loadWorldData():
	#top path
	tier_2_node_enemy_2.text = GameManager.worldPathA[0]
	tier_3_node_enemy_4.text = GameManager.worldPathA[1]
	tier_4_node_enemy_8.text = GameManager.worldPathA[2]
	tier_5_node_enemy_10.text = GameManager.worldPathA[3]
	tier_6_node_enemy_12.text = GameManager.worldPathA[4]
	#bottom path
	tier_2_node_enemy_3.text = GameManager.worldPathB[0]
	tier_3_node_enemy_5.text = GameManager.worldPathB[1]
	tier_4_node_enemy_7.text = GameManager.worldPathB[2]
	tier_5_node_enemy_9.text = GameManager.worldPathB[3]
	tier_6_node_enemy_11.text = GameManager.worldPathB[4]



# all node Logic
func MapNodePressed(nodeText):
	if nodeText == "Campfire":
		PlayerHealEffect()
		await get_tree().create_timer(0.9).timeout 
		if GameManager.player_health >= 76:
			GameManager.player_health = 100
		else:
			GameManager.player_health += 25
		var healthLabelInt = GameManager.player_health
		texture_enemy_health_bar.value = float(healthLabelInt)
		GameManager.map_progression += 1
		get_tree().change_scene_to_file("res://Scenes/world_map.tscn")
	elif nodeText == "Elite":
		GameManager.EnemyIsElite = true
		GameManager.map_progression += 1
		GameManager.reset_combat()
		GameManager.start_combat()
		get_tree().change_scene_to_file("res://Scenes/CombatScene.tscn")
	elif nodeText == "Enemy":
		GameManager.EnemyIsElite = false
		GameManager.map_progression += 1
		GameManager.reset_combat()
		GameManager.start_combat()
		get_tree().change_scene_to_file("res://Scenes/CombatScene.tscn")
	





#Campfires

func _on_button_pressed() -> void:
	if GameManager.player_health >= 76:
		GameManager.player_health = 100
	else:
		GameManager.player_health += 25
	var healthLabelInt = GameManager.player_health
	texture_enemy_health_bar.value = float(healthLabelInt)
	GameManager.map_progression += 1
	get_tree().change_scene_to_file("res://Scenes/world_map.tscn")

func _on_button_2_pressed() -> void:
	if GameManager.player_health >= 76:
		GameManager.player_health = 100
	else:
		GameManager.player_health += 25
	var healthLabelInt = GameManager.player_health
	texture_enemy_health_bar.value = float(healthLabelInt)
	GameManager.map_progression += 1
	get_tree().change_scene_to_file("res://Scenes/world_map.tscn")
