extends Control

@onready var pause_menu = $"."


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pauseButton"):
		paused_or_unpaused()
		SceneManager.scene_file_path = "res://Menus/pause_menu.tscn"
	
	
func paused_or_unpaused():
	if get_tree().paused == true:
		pause_menu.hide()
		get_tree().paused = false
		
	elif get_tree().paused == false:
		pause_menu.show()
		get_tree().paused = true
	
	
func pressed_on_options_button():
	get_tree().paused = false
	SceneManager.load_scene("res://Menus/options_menu.tscn")
	
func pressed_on_exit_button():
	get_tree().quit()
