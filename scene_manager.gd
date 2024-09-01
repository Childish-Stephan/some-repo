# SceneManager.gd
extends Node


# Keep track of the scene
var sceneArray: Array = []

func _ready():
	# Loads the initial scene
	load_scene("res://Menus/main_menu.tscn")
	
func load_scene(scene_path: String) -> void:
	# Gets the current scene and add it to the scene history array alongside the filename
	if get_tree().current_scene:
		sceneArray.append(get_tree().current_scene.scene_file_path)
	
	# When we load the scene, we want to change the scene to some other path
	get_tree().change_scene_to_packed(load(scene_path))
	
func go_back() -> void:
	# Only execute if the array has a value bigger than 0
	if sceneArray.size() > 0:
		var previous_scene = sceneArray.pop_back()
		get_tree().change_scene_to_packed(load(previous_scene))
		print(sceneArray, previous_scene)
		if previous_scene == "res://Levels/test_level.tscn":
			get_tree().paused = true
