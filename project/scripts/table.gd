extends Node2D

var ball_scene = preload("res://scenes/ball.tscn") # Will load when parsing the script.

var ball_type_enum = preload("res://scripts/ball_type_enum.gd")

var white_ball_origin : Vector2 = Vector2()
var cue_stick : Node2D
var current_player : int = 1
var other_player : int = 2
var owns_halfs : int = 0
var allow_shot : bool = false
var balls_in_round = []
var white_ball : RigidBody2D
var player_switch_needed : bool = false

var _round : int = 0

var player_ball_types = [ball_type_enum.BALL_TYPE.UNDEFINED, ball_type_enum.BALL_TYPE.UNDEFINED]

func _ready():
	white_ball = find_node("white-ball")
	white_ball_origin = white_ball.position
	cue_stick = find_node("cue-stick")
	_on_ballsdiamond_movement_ended()	

func _process(delta):
	pass

func _on_game_reset_sig():
	pass

func _on_cuestick_shot(impulse):
	if $"cue-stick".is_visible():
		white_ball.apply_impulse(Vector2(),impulse)
	else:
		print("No shots allowed...")

func _on_holegroup_body_entered(body):
	print("Hit hole %s." % ball_type_enum.to_string(body.type) )
	
	var group = ball_type_enum.to_string(body.type)
	
	if ball_type_enum.is_white(body.type):
		_add_white_ball()
	
	body.queue_free()
	
	balls_in_round.append(body.type)

func _switch_player():
	if current_player == 1:
		$player1.active = false
		$player2.active = true
		current_player = 2
		other_player = 1
	else:
		$player1.active = true
		$player2.active = false
		current_player = 1
		other_player = 2

func _on_ballsdiamond_movement_ended():
	
	if _round > 0:
		var list_of_balls = ""
		for b in balls_in_round:
			list_of_balls += ball_type_enum.to_string(b) + " "
			
		print("Round %d ended: %s" % [_round, list_of_balls])
		
		if ball_type_enum.is_undefined(player_ball_types[current_player-1]):
			_first_player_assignment(balls_in_round)
		else:
			_process_balls()
		
		if player_switch_needed:
			_switch_player()
			player_switch_needed = false
	
	_round += 1;
	
	print("Starting Round %d for Player %d [%s] --------------------------------" % [_round, current_player, ball_type_enum.to_string(player_ball_types[current_player-1]) ])	
	
	balls_in_round.clear()
	$"cue-stick".show()
	$"cue-stick".position = white_ball.position

func _process_balls():
	if balls_in_round.size() == 0:
		player_switch_needed = true
	else:
		player_switch_needed = false
		for b in balls_in_round:
			if b != player_ball_types[current_player-1]:
				player_switch_needed = true

func _first_player_assignment(balls_in_round):
	print ("Deciding ball assignment.")
	var first = ball_type_enum.BALL_TYPE.UNDEFINED

	if balls_in_round.size() > 0:
		first = balls_in_round[0]
		if ball_type_enum.is_half(first):
			player_ball_types[current_player-1] = ball_type_enum.BALL_TYPE.HALF
			player_ball_types[other_player-1] = ball_type_enum.BALL_TYPE.FULL
		else:
			player_ball_types[current_player-1] = ball_type_enum.BALL_TYPE.FULL
			player_ball_types[other_player-1] = ball_type_enum.BALL_TYPE.HALF
	else:
		player_switch_needed = true	
	
	var i=0
	for b in balls_in_round:
		print("Ball %d: %s" % [i, b])
		i += 1

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
	$"balls-diamond".add_child(white_ball)

func _on_ballsdiamond_movement_started():
	$"cue-stick".hide()
	allow_shot = false
	pass # Replace with function body.
