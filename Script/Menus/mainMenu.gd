extends Control

func pressed_on_play_button():
	SceneManager.load_scene("res://Levels/test_level.tscn")
	
func pressed_on_options_button():
	SceneManager.load_scene("res://Menus/options_menu.tscn")
	
func pressed_on_exit_button():
	get_tree().quit()
