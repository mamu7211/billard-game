extends Node2D

signal reset_sig

var reset : bool = true

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if reset:
		emit_signal("reset_sig")
		reset = false
	

func _unhandled_input(event):
    if event is InputEventKey:
        if event.pressed and event.scancode == KEY_ESCAPE:
            reset = true
