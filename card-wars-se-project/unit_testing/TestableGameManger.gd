extends Node

@export var CombatScene: PackedScene
@export var EnemyScene: PackedScene
@export var PlayerHandScene: PackedScene 

const PLAYER_MAX_HEALTH = 100 # subject to change in the future
const ENEMY_MAX_HEALTH = 100 # subject to change in the the future
var enemy_health: int = 100
var player_health: int = 100
var player_turn: bool = true
var player_def: int = 0
var card_types = ["attack", "heal", "defend"] 
var combat_instance = null  # Declare combat_instance globally

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
