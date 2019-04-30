extends Node2D

var ball_scene = preload("res://scenes/ball.tscn")
var ball_type_enum = preload("res://scripts/ball_type_enum.gd")

var white_ball_origin : Vector2 = Vector2()
var cue_stick : Node2D
var active_player
var other_player
var balls_in_round = []
var white_ball : RigidBody2D
var player_switch_needed : bool = false

var _round : int = 0

var player_ball_types = [ball_type_enum.BALL_TYPE.UNDEFINED, ball_type_enum.BALL_TYPE.UNDEFINED]

func _ready():
	white_ball = find_node("white-ball")
	white_ball_origin = white_ball.position
	cue_stick = find_node("cue-stick")
	active_player = $player1
	active_player.active = true
	other_player = $player2
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

func _on_holegroup_body_entered(body : RigidBody2D):
	print("Hit hole %s." % ball_type_enum.to_string(body.type) )
	
	body.visible = false
	body.get_parent().remove_child(body)
	
	balls_in_round.append(body)
	
	if active_player.type == ball_type_enum.BALL_TYPE.UNDEFINED:
		_first_player_assignment()
		
	if ball_type_enum.is_half(body.type) || ball_type_enum.is_full(body.type):
		if body.type == active_player.type:
			active_player.add_ball(body.number)
		else:
			other_player.add_ball(body.number)
	else:
		print("White or black sunk.")
	if body.type == active_player.type:
		$"good-hit-sound".play()
	else:
		$"bad-hit-sound".play()

func _switch_player():	
	var old = active_player
	
	active_player = other_player
	other_player = old
	
	other_player.active = false
	active_player.active = true
	
	$"switch-player".play()

func _on_ballsdiamond_movement_ended():
	if _round > 0:
		var list_of_balls = ""
		var delim = ""
		for b in balls_in_round:
			list_of_balls += delim + "'" + ball_type_enum.to_string(b.type)  + "'"
			delim = ", "
			
		print("Round %d ended with balls: %s" % [_round, list_of_balls])
		
		_process_balls()
		
		if player_switch_needed:
			_switch_player()
			player_switch_needed = false
	
	_round += 1;
	
	print("Starting Round %d --------------------------------" % _round)	
	print("Current Player: %s" % active_player.to_string())
	print("Other Player: %s" % other_player.to_string())
	for b in balls_in_round:
		if ball_type_enum.is_white(b.type):
			print("White ball will be added.")
			_add_white_ball()
			_switch_player()
		b.queue_free()
	
	balls_in_round.clear()
	$"cue-stick".show()
	$"cue-stick".position = white_ball.position

func _process_balls():
	if balls_in_round.size() == 0:
		player_switch_needed = true
	else:
		player_switch_needed = false
		for b in balls_in_round:
			if b.type != active_player.type:
				player_switch_needed = true

func _first_player_assignment():
	print ("Deciding ball assignment.")
	if balls_in_round.size() > 0:
		var first = balls_in_round[0]
		if ball_type_enum.is_half(first.type):
			print("Assigning half to Player %d" % active_player.player_number)
			active_player.type = ball_type_enum.BALL_TYPE.HALF
			other_player.type = ball_type_enum.BALL_TYPE.FULL
		else:
			print("Assigning full to Player %d" % active_player.player_number)
			active_player.type = ball_type_enum.BALL_TYPE.FULL
			other_player.type = ball_type_enum.BALL_TYPE.HALF

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
