extends Label

var ball_type_enum = preload("res://scripts/ball_type_enum.gd")
var ball_scene = preload("res://scenes/ball.tscn")

export (bool) var active = false
export (int) var player : int = 2
export (ball_type_enum.BALL_TYPE) var type = ball_type_enum.BALL_TYPE.UNDEFINED

var player_number : int = 0

var balls = []

func _ready():
	set_player(player)

func set_player(player):
	player_number = player
	text = "PLAYER %d" % player_number
	
func set_active(active):
	self.active = active
	if self.active: 
		self.modulate.a=1
	else:
		self.modulate.a=0.25

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
	var dir = 1
	var offset = 0
	if player_number==2: 
		dir=-1
		offset = 40
	ball.position = Vector2(dir * (self.get_size().x/2 + 32*(balls.size()-1)),0)
	ball.collision_layer = 3
	ball.collision_mask = 3
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
