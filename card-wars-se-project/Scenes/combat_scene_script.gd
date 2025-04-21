extends Control

@onready var enemy_health_bar = $EnemyHealthBar
@onready var player_health_bar = $PlayerHealthBar
@onready var turn_indicator = $TurnIndicator
@onready var player_hand_container = $PlayerHandContainer
@onready var attackAnimation = $attackAnimation
@onready var player_def: Label = $PlayerDef
@onready var enemy_heal_animation: AnimatedSprite2D = $EnemyHealAnimation
@onready var damage_overlay: Sprite2D = $DamageOverlay
@onready var texture_player_health_bar: TextureProgressBar = $TexturePlayerHealthBar
@onready var texture_enemy_health_bar: TextureProgressBar = $TextureEnemyHealthBar
@onready var enraged_icon: Sprite2D = $EnragedIcon
@onready var healing_icon: Sprite2D = $HealingIcon
@onready var enraged_label: Label = $EnragedLabel
@onready var heal_label: Label = $HealLabel
@onready var heal_overlay: Sprite2D = $HealOverlay
@onready var sheild_animations: AnimationPlayer = $SheildAnimations
@onready var player_blocked_animation_player: AnimationPlayer = $PlayerBlockedAnimationPlayer
@onready var enemy_health_number_max: Label = $EnemyHealthNumberMax
@onready var enemy_health_current_number: Label = $EnemyHealthCurrentNumber
@onready var player_health_number: Label = $PlayerHealthNumber

var enemymaxhealth = 0

func _ready():
	enemymaxhealth = GameManager.enemy_health_comparator
	attackAnimation.visible = false
	enemy_heal_animation.visible = false
	print("Combat Scene Initialized")
	master_update()
	load_player_hand()
	
	texture_enemy_health_bar.max_value = enemymaxhealth
	enemy_health_number_max.text = "/" + str(int(enemymaxhealth))
	player_health_number.text = str(GameManager.player_health) + "/100"
	enemy_health_current_number.text = str(int(enemymaxhealth))


	texture_enemy_health_bar.value = enemymaxhealth #weird fix

func master_update():
	var game_manager = get_tree().root.get_node_or_null("GameManager")
	
	update_health_display(game_manager)
	update_defense_display(game_manager)
	update_turn_indicator(game_manager)
	

func update_health_display(game_manager):
	if game_manager:
		print("Updating health bars - Player:", game_manager.player_health, "Enemy:", game_manager.enemy_health)
		enemy_health_current_number.text=  str(game_manager.enemy_health)
		texture_player_health_bar.value = game_manager.player_health
		player_health_bar.value = game_manager.player_health
		texture_enemy_health_bar.value = game_manager.enemy_health
		player_health_number.text = str(GameManager.player_health) + "/100"

	else:
		print("ERROR: GameManager not found!")

func load_player_hand():
	var game_manager = get_tree().root.get_node_or_null("GameManager")
	if game_manager and game_manager.PlayerHandScene:
		print("Loading Player Hand Scene")
		var player_hand_instance = game_manager.PlayerHandScene.instantiate()
		player_hand_container.add_child(player_hand_instance)
	else:
		print("ERROR: GameManager or PlayerHandScene not found!")

func update_turn_indicator(game_manager):
	if game_manager:
		turn_indicator.text = "Player's Turn" if game_manager.player_turn else "Enemy's Turn"
		print("Turn Indicator Updated - Current Turn:", turn_indicator.text)
	else:
		print("ERROR: GameManager not found!")
	
func UpdateExactHealth():
	pass
	
func playAttackAnimation():
	attackAnimation.visible = true
	attackAnimation.play('default')
	await attackAnimation.animation_finished
	attackAnimation.visible= false
	
func PlayerTakeDamage():
	damage_overlay.modulate.a8 = 90
	await get_tree().create_timer(0.9).timeout 
	damage_overlay.modulate.a8 = 0

func PlayerHealEffect():
	heal_overlay.modulate.a8 = 90
	await get_tree().create_timer(0.9).timeout 
	heal_overlay.modulate.a8 = 0
	
func playEnemyHealAnimation():
	enemy_heal_animation.visible = true
	enemy_heal_animation.play('default')
	await enemy_heal_animation.animation_finished
	enemy_heal_animation.visible= false

func update_defense_display(game_manager):
	if game_manager:
		player_def.text = "Def: " + str(game_manager.player_def)
		print("Defense Display Updated - Defense:", game_manager.player_def)
	else:
		print("ERROR: GameManager not found!")

func SheildFlickerAnimation():
	sheild_animations.play("SheildAnimationFlicker")

func sheildBlockAnimation():
	player_blocked_animation_player.play("PlayerBlocked")


func updateEnemyNextMoveIndicator(enemy_next_action):
	if enemy_next_action == 0:
		enraged_icon.visible = true
		healing_icon.visible= false
		enraged_label.visible = true
		heal_label.visible= false
	elif enemy_next_action == 1:
		enraged_icon.visible = false
		healing_icon.visible= true
		enraged_label.visible = false
		heal_label.visible= true
		
