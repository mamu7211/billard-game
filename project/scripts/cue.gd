extends Node2D

signal shot(impulse)

var cue_sprite : Sprite
var loaded : float = 0.0
var loading : bool = false

func _ready():
	cue_sprite = find_node("cue-sprite")

func _process(delta):
	if !loading && loaded>=0.01:
		print("Shooting")
		var impulse : Vector2 = Vector2(-clamp(loaded,0,1),0).rotated(cue_sprite.rotation) * 3000;
		reset()
		emit_signal("shot",impulse)
	elif loading && loaded <=1.5:
		loaded += 0.7 * delta
	elif loaded > 1.5:
		print("Resetting.")
		reset()
		
	get_node("dotted-line").position = get_local_mouse_position()
	get_node("dotted-line").rotation = get_local_mouse_position().angle() + PI
	
	get_node("cue-sprite").set_offset(Vector2(7 + clamp(loaded,0,1) * 18,-3.5))
	get_node("cue-sprite").rotation = get_local_mouse_position().angle() + PI

func _input(event):
	if event is InputEventMouseButton:
		var mbe : InputEventMouseButton = event
		loading = mbe.is_pressed()

func reset():
	visible = true
	loaded = 0.0
	loading = false