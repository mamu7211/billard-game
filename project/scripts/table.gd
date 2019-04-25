extends Node2D

var ball_scene = preload("res://scenes/ball.tscn") # Will load when parsing the script.

func _input(event):
	if event is InputEventMouseButton:
			print("Applying force...")
			var ball : RigidBody2D = find_node("white-ball")
			var direction = Vector2(-1,0);
			var impulse = direction * 100;
			ball.apply_impulse(Vector2(),impulse)

func _on_game_reset_sig():
	var ball = find_node("white-ball")
	ball.queue_free()
	remove_child(ball)
	add_child(ball_scene.instance())
#	var newBall = instance
