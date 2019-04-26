extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	set_offset(Vector2(7 + clamp(get_parent().loaded,0,1) * 20,-3))
	rotation = get_parent().get_local_mouse_position().angle()		
#	get_child(0).material.set_shader_param("cut_off", 1-clamp(get_parent().loaded,0,1))
	
