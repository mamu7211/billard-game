extends Node2D

var ball_scene = preload("res://scenes/ball.tscn")
var ball_type_enum = preload("res://scripts/ball_type_enum.gd")
var absorbent = preload("res://physics/ball-absorbent.tres")

const GRAVITY = 200.0
var velocity = Vector2(0,1000)

func _ready():
	pass

func add_ball(type, number):
	print("Add new ball...")
	var ball : RigidBody2D = ball_scene.instance()
	ball.position = Vector2()
	ball.add_to_group("tray")
	ball.name="tray-white-ball"
	ball.bounce=0
	ball.physics_material_override = absorbent
	ball.type = type
	ball.number = number
	#ball.collision_layer = 2
	$"gravity-area".add_child(ball)