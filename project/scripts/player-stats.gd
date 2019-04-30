extends AnimatedSprite

var ball_type_enum = preload("res://scripts/ball_type_enum.gd")
var ball_scene = preload("res://scenes/ball.tscn")

export (bool) var active = false
export (int) var player : int = 2
export (ball_type_enum.BALL_TYPE) var type = ball_type_enum.BALL_TYPE.UNDEFINED

var player_number : int = 0

var frames_player_1 = preload("res://sprite-frames/player-1-frames.tres")
var frames_player_2 = preload("res://sprite-frames/player-2-frames.tres")

var balls = []

func _ready():
	set_player(player)

func set_player(player):
	player_number = player
	if player_number == 1:
		set_sprite_frames(frames_player_1)
	else:
		set_sprite_frames(frames_player_2)

func set_ball_type(type): 
	self.type = type
	_show_info()

func add_ball(number):
	balls.append(number)
	_show_info()

	print("Add new white ball...")
	var ball = ball_scene.instance()
	ball.type = type
	ball.number = number
	ball.position = Vector2(26*(balls.size()-1),0)
	ball.collision_layer = 3
	ball.collision_mask = 3
	ball.scale = Vector2(1,3)
	$balls.add_child(ball)

func to_string():
	var info = "Player %d / %s : " % [player,ball_type_enum.to_string(type)]
	var delim = ""
	for b in balls:
		info += delim + ("%d" % b)
		delim = ", "
	
	return info

func _show_info():
	print(to_string())

func _process(delta):
	if player_number != player:
		set_player(player)
	
	if active && animation != "on":
		self.play("switch-on")
	elif !active && animation != "off":
		self.play("switch-off")
	

func _on_AnimatedSprite_animation_finished():
	if animation == "switch-off":
		active = false
		self.play("off")
	if animation == "switch-on":
		active = true
		self.play("on")
	
