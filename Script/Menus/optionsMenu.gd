extends Control

const PauseMenu = preload("res://Script/Menus/pauseMenu.gd")
@onready var pause_menu = $"."


func _process(delta):
	if Input.is_action_just_pressed("backButton"):
		SceneManager.go_back()
		if SceneManager.sceneArray.has("res://Levels/test_level.tscn"):
			get_tree().paused = true

			
