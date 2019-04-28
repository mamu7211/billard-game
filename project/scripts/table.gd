extends Node2D

var ball_scene = preload("res://scenes/ball.tscn") # Will load when parsing the script.
var white_ball_origin : Vector2 = Vector2()
var cue_stick : Node2D
var current_player : int = 1
var owns_halfs : int = 0
var allow_shot : bool = false
var balls_in_round = []
var white_ball : RigidBody2D

func _ready():
	white_ball = find_node("white-ball")
	white_ball_origin = white_ball.position
	cue_stick = find_node("cue-stick")
	_on_ballsdiamond_movement_ended()	

func _process(delta):
	allow_shot = white_ball!=null && white_ball.linear_velocity.length()<2
	if allow_shot:
		if white_ball != null:
			cue_stick = find_node("cue-stick")
			cue_stick.position = white_ball.position
			cue_stick.show()
	else:
		cue_stick.hide()

func _on_game_reset_sig():
	pass

func _on_cuestick_shot(impulse):
	if allow_shot && white_ball!=null:
		white_ball.apply_impulse(Vector2(),impulse)
	else:
		print("No shots allowed...")

func _on_holegroup_body_entered(body):
	print("Hit hole.")
	
	var isWhite = body.is_in_group("white")
	var isBlack = body.is_in_group("black")
	var isHalf = body.is_in_group("half")
	var isFull = body.is_in_group("full")
	
	var group = "undefined"
	if body.is_in_group("white"):
		group = "white" 
	elif body.is_in_group("black"):
		group = "black"
	elif body.is_in_group("half"):
		group = "half"
	else:
		group = "full"
	
	body.queue_free()
	print("Group was %s" % group)
	
	if body == white_ball:
		_add_white_ball()
	
	balls_in_round.append(group)

func _switch_player():
	if current_player == 1:
		$player1.active = false
		$player2.active = true
		current_player = 2
	else:
		$player1.active = true
		$player2.active = false
		current_player = 1

func _on_ballsdiamond_movement_ended():
	var list_of_balls = ""
	for b in balls_in_round:
		list_of_balls += b + " "
		
	print("Round ended: %s" % list_of_balls)
	
	if _contains("white",balls_in_round):
		print("White in hole.")
	
	if _contains("black",balls_in_round):
		print("Black in hole.")
	
	balls_in_round.clear()
	allow_shot = true
	
	print("Starting new Round --------------------------------")

func _contains(type,list):
	for ball in list:
		if ball == type:
			return true
	return false

func _add_white_ball():
	print("Add new white ball...")
	white_ball = ball_scene.instance()
	white_ball.position = white_ball_origin
	white_ball.add_to_group("white")
	white_ball.name="white-ball"
	add_child(white_ball)

func _on_ballsdiamond_movement_started():
	allow_shot = false
	pass # Replace with function body.
