extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var boss_sprite: AnimatedSprite2D = $"Boss Sprite"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameManager.map_progression < 8:
		animated_sprite_2d.visible= true
		boss_sprite.visible = false
	else:
		animated_sprite_2d.visible= false
		boss_sprite.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
