extends Sprite

func _ready():
	pass # Replace with function body.

func _process(delta):
	position = get_parent().get_local_mouse_position()
	rotation = get_parent().get_local_mouse_position().angle() + PI
