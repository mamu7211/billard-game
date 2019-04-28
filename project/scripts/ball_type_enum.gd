extends Node

enum BALL_TYPE {UNDEFINED, WHITE, BLACK, FULL, HALF}

static func is_undefined(type) -> bool:
	return type == BALL_TYPE.UNDEFINED

static func is_white(type) -> bool:
	return type == BALL_TYPE.WHITE

static func is_black(type) -> bool:
	return type == BALL_TYPE.BLACK

static func is_half(type) -> bool:
	return type == BALL_TYPE.HALF

static func is_full(type) -> bool:
	return type == BALL_TYPE.FULL

static func to_string(type) -> String:
	var result = "undefined"
	match type:
		BALL_TYPE.WHITE:
			result = "white"
		BALL_TYPE.BLACK:
			result = "black"
		BALL_TYPE.HALF:
			result = "half"
		BALL_TYPE.FULL:
			result = "full"
	
	return result
