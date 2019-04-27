extends AnimatedSprite

export (bool) var active = false
export (int) var player : int = 2

var current_player : int = 0

var frames_player_1 = preload("res://sprite-frames/player-1-frames.tres")
var frames_player_2 = preload("res://sprite-frames/player-2-frames.tres")
	
func _ready():
	set_player(player)
	

func set_player(player):
	current_player = player
	if current_player == 1:
		set_sprite_frames(frames_player_1)
	else:
		set_sprite_frames(frames_player_2)
		

func _process(delta):
	if current_player != player:
		set_player(player)
	
	if active && animation != "on":
		self.play("switch-on")
	elif !active && animation != "off":
		self.play("switch-off")
	

func _on_AnimatedSprite_animation_finished():
	if animation == "switch-off":
		active = false
		self.play("off")
	if animation == "switch-on":
		active = true
		self.play("on")
	
