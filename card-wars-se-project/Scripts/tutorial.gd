extends Control
@onready var start_panel: Panel = $StartPanel
@onready var start_button: Button = $StartPanel/StartButton
@onready var battle_panel: Panel = $BattlePanel
@onready var battle_button: Button = $BattlePanel/BattleButton
@onready var enemy_panel: Panel = $EnemyPanel
@onready var enemy_button: Button = $EnemyPanel/EnemyButton
@onready var player_panel: Panel = $PlayerPanel
@onready var player_button: Button = $PlayerPanel/PlayerButton
@onready var card_panel: Panel = $CardPanel
@onready var card_button: Button = $CardPanel/CardButton
@onready var reward_panel: Panel = $RewardPanel
@onready var reward_button: Button = $RewardPanel/RewardButton
@onready var map_panel: Panel = $MapPanel
@onready var map_button: Button = $MapPanel/MapButton
@onready var skip_button: Button = $SkipButton

func on_ready():
	pass
	# disable all unused buttons
	# reenable and disable buttons with each press
	# toggle visibility with button presses
	# modify new game to go to tutorial
	# have tutorial end with getting a card
	# skip tutorial does not get a card
