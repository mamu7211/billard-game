extends Node2D

signal reset_sig

var reset : bool = true
var poi : Vector2 = Vector2()

func _ready():
	reset = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if reset:
		print("Emitting reset signal.")
		emit_signal("reset_sig")
		reset = false

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			print("Resetting Game.")
			reset = true
