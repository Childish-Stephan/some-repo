extends Control

@onready var pause_menu = $"."


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pauseButton"):
		paused_or_unpaused()
	
func paused_or_unpaused():
	if get_tree().paused == true:
		pause_menu.hide()
		get_tree().paused = false
		
	elif get_tree().paused == false:
		pause_menu.show()
		get_tree().paused = true
	

	
func pressed_on_options_button():
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
	
func pressed_on_exit_button():
	get_tree().quit()
