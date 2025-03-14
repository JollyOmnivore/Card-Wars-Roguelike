extends GutTest


var PlayerHandScript = preload("res://Scenes/player_hand_scene.gd")
var hand_instance: Control

class DummyGameManager:
	extends Node
	var last_action: String = ""
	func player_action(action: String) -> void:
		last_action = action

var dummyGameManager: DummyGameManager

func before_each() -> void:
	if not get_parent():
		get_tree().root.add_child(self)
	dummyGameManager = DummyGameManager.new()
	dummyGameManager.name = "GameManager"
	get_tree().root.add_child(dummyGameManager)
	hand_instance = Control.new()
	hand_instance.set_script(PlayerHandScript)
	var btn1 = Button.new()
	btn1.name = "Button1"
	hand_instance.add_child(btn1)
	var btn2 = Button.new()
	btn2.name = "Button2"
	hand_instance.add_child(btn2)
	var btn3 = Button.new()
	btn3.name = "Button3"
	hand_instance.add_child(btn3)
	add_child(hand_instance)
	hand_instance._ready()
	await get_tree().process_frame

func after_each() -> void:
	if dummyGameManager and dummyGameManager.get_parent():
		dummyGameManager.queue_free()
		await get_tree().process_frame
	
	if hand_instance and hand_instance.get_parent():
		hand_instance.queue_free()
		await get_tree().process_frame

func test_initial_button_setup():
	var btn1 = hand_instance.get_node("Button1") as Button
	var btn2 = hand_instance.get_node("Button2") as Button
	var btn3 = hand_instance.get_node("Button3") as Button
	
	assert_eq(btn1.text, "Defend", "Button1 should be set to 'Defend'")
	assert_eq(btn2.text, "Attack", "Button2 should be set to 'Attack'")
	assert_eq(btn3.text, "Heal", "Button3 should be set to 'Heal'")
