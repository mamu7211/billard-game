extends RigidBody2D

var initial_position : Vector2 = Vector2()

enum BALL_TYPE {WHITE, BLACK, FULL, HALF}

export(BALL_TYPE) var type = BALL_TYPE.WHITE
export(int) var number = 1

var offset : int = 0
var sprite : Sprite

func _ready():	
	if type == BALL_TYPE.WHITE:
		number = 1
		offset = 0
	elif type == BALL_TYPE.BLACK:
		number = 1
		offset = 1
	elif type == BALL_TYPE.FULL:
		offset = 2
	else:
		offset = 9
	if offset > 1 && number < 1 && number > 7:
		number = 1
	print("Created Ball: type:%s, number:%d, offset:%d" % [type,number,offset])
	sprite = get_child(0)
	sprite.region_rect.position = Vector2((offset+number-1)*14,1)
	sprite.region_rect.size = Vector2(14,14)