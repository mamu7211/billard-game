extends RigidBody2D

var initial_position : Vector2 = Vector2()

const ball_type_enum = preload("res://scripts/ball_type_enum.gd")

export(ball_type_enum.BALL_TYPE) var type = ball_type_enum.BALL_TYPE.WHITE
export(int) var number = 1

var offset : int = 0
var sprite : Sprite

func _ready():	
	if type == ball_type_enum.BALL_TYPE.WHITE:
		number = 1
		offset = 0
	elif type == ball_type_enum.BALL_TYPE.BLACK:
		number = 1
		offset = 1
	elif type == ball_type_enum.BALL_TYPE.FULL:
		offset = 2
	else:
		offset = 9
	if offset > 1 && number < 1 && number > 7:
		number = 1
	print("Created Ball: name:%s, type:%s, number:%d, offset:%d" % [name, type,number,offset])
	sprite = get_child(0)
	sprite.region_rect.position = Vector2((offset+number-1)*14,1)
	sprite.region_rect.size = Vector2(14,14)