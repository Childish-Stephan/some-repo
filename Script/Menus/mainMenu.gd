extends Control

func pressed_on_play_button():
	get_tree().change_scene_to_file("res://Levels/test_level.tscn")
	
func pressed_on_options_button():
	get_tree().change_scene_to_file("res://Menus/options_menu.tscn")
	
func pressed_on_exit_button():
	get_tree().quit()
