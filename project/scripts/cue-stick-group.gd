extends Node2D

func _process(delta):
	
	position = get_parent().poi
	rotation = get_parent().get_local_mouse_position().angle_to_point(position)
	
