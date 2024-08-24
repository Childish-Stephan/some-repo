extends Area2D

@onready var timer = $Timer

func on_entering_area(body):
	timer.start()
	
func on_timeout():
	get_tree().reload_current_scene()
