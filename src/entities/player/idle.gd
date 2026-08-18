extends State
class_name Idle
@export var player:CharacterBody2D



func physics_update(delta:float):
	if Input.is_action_just_pressed("dash_down"):
		change.emit(self,"Dash_Down")
	#if Input.is_action_just_released("jump"):
		#player.velocity.y=player.old_y
		#Global.slow_factor=1
	if Input.is_action_just_pressed("jump"):
		if player.is_on_floor():
			change.emit(self,"Jump")
		#player.old_y=player.velocity.y
	#if Input.is_action_pressed("jump") and player.time_juice>0 and player.is_on_floor():
		#Global.slow_factor=.1
	#elif Input.is_action_pressed("jump") and player.time_juice>0:
		#player.time_juice-=1*delta
		#Global.slow_factor=.1
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		change.emit(self,"Move")
	player.velocity.x=lerp(player.velocity.x,0.0,25*delta)
	
