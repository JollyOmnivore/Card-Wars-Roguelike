extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var boss_sprite: AnimatedSprite2D = $"Boss Sprite"
@onready var elite_enemy: AnimatedSprite2D = $EliteEnemy


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Is enemy elite?")
	print(GameManager.EnemyIsElite)
	if GameManager.EnemyIsElite == true:
		animated_sprite_2d.visible= false
		boss_sprite.visible = false
		elite_enemy.visible = true
	elif GameManager.map_progression < 8: #if check must stay in this order
		animated_sprite_2d.visible= true
		boss_sprite.visible = false
		elite_enemy.visible = false
	else:
		animated_sprite_2d.visible= false
		boss_sprite.visible = true
		elite_enemy.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
