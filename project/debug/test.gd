extends Node2D

var ball_type_enum = preload("res://scripts/ball_type_enum.gd")

func _ready():
	$player1.set_player(1)
	$player2.set_player(2)

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_ESCAPE:
			$player1.set_active(false)
			$player2.set_active(false)
		elif event.scancode == KEY_1:
			$player1.set_active(true)
			$player2.set_active(false)
		elif event.scancode == KEY_2:
			$player1.set_active(false)
			$player2.set_active(true)
		elif event.scancode == KEY_3:
			$player1.set_active(true)
			$player2.set_active(true)
		elif event.scancode == KEY_F:
			$"fail-sign".play("switch-on")
		elif event.scancode == KEY_B && !Input.is_key_pressed(KEY_B):
			if $player1.active:
				$player1.add_ball($player1.balls.size()+1)
			elif $player2.active:
				$player2.add_ball($player2.balls.size()+1)