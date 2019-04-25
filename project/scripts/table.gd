extends Node2D

var poi : Vector2 = Vector2()

func _process(delta):
	poi = find_node("white-ball").position
