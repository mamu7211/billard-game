extends Node2D

var ball_scene = preload("res://scenes/ball.tscn") # Will load when parsing the script.
var white_ball_origin : Vector2 = Vector2()
var white_ball : RigidBody2D
var cue_stick : Node2D

func _ready():
	white_ball = find_node("white-ball")
	white_ball_origin = white_ball.position
	cue_stick = find_node("cue-stick")

func _process(delta):
	if white_ball != null:
		cue_stick.position = white_ball.position
		if white_ball.linear_velocity.length() > 5:
			cue_stick.hide()
		else:
			cue_stick.show()

func _on_game_reset_sig():
	white_ball.queue_free()
	remove_child(white_ball)
	white_ball = ball_scene.instance()
	white_ball.position = white_ball_origin
	add_child(white_ball)


func _on_cuestick_shot(impulse):
	if white_ball != null:
		white_ball.apply_impulse(Vector2(),impulse)


func _on_holegroup_body_entered(body):
	print("Hit hole.")
	if body == white_ball:
		_on_game_reset_sig()
	else:
		body.queue_free()
		
