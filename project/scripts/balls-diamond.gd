extends Node2D

const VELOCITY_THRESHOLD = 5

signal movement_started
signal movement_ended

var moving : bool = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	var wasMoving = moving==true
	moving = false
	
	for ball in self.get_children():
		if ball is RigidBody2D:
			var body : RigidBody2D = ball
			if body.linear_velocity.length() > VELOCITY_THRESHOLD:
				moving = true
	
	if  moving && !wasMoving:
		print("Moving started...")
		emit_signal("movement_started")
		
	if !moving && wasMoving:
		print("Moving ended...")
		for ball in self.get_children():
			if ball is RigidBody2D:
				var body : RigidBody2D = ball
				body.linear_velocity = Vector2()
		
		emit_signal("movement_ended")
