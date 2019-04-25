extends Node2D

var ball_scene = preload("res://scenes/ball.tscn") # Will load when parsing the script.
var white_ball_origin : Vector2 = Vector2()
var white_ball : RigidBody2D

func _ready():
	white_ball = find_node("white-ball")
	white_ball_origin = white_ball.position

func _input(event):
	if event is InputEventMouseButton:
			print("Applying force...")
			var direction = Vector2(-1,0);
			var impulse = direction * 700;
			white_ball.apply_impulse(Vector2(),impulse)

func _on_game_reset_sig():
	white_ball.queue_free()
	remove_child(white_ball)
	white_ball = ball_scene.instance()
	white_ball.position = white_ball_origin
	add_child(white_ball)
