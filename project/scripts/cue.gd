extends Node2D

signal shot(impulse)

var cue_sprite : Sprite

func _ready():
	cue_sprite = find_node("cue-sprite")

func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		print("Shot...")
		var impulse : Vector2 = Vector2(-1,0).rotated(cue_sprite.rotation) * 700;
		emit_signal("shot",impulse)
		hide()
