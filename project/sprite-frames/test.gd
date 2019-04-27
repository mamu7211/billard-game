extends Node2D

func _ready():
	$player1.set_player(1)
	$player2.set_player(2)

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_ESCAPE:
			$player1.active=false
			$player2.active=false
		elif event.scancode == KEY_1:
			$player1.active=true
			$player2.active=false
		elif event.scancode == KEY_2:
			$player1.active=false
			$player2.active=true
		elif event.scancode == KEY_3:
			$player1.active=true
			$player2.active=true			
	