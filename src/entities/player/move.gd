extends State
class_name Move

@export var player:CharacterBody2D
var speed:float=400

func physics_update(delta:float):
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

	if Input.is_action_just_pressed("dash_down"):
		change.emit(self,"Dash_Down")
	if Input.is_action_pressed("left"):
		player.velocity.x=lerp(player.velocity.x,-speed,15*delta)
	elif Input.is_action_pressed("right"):
		player.velocity.x=lerp(player.velocity.x,speed,15*delta)
	else:
		player.velocity.x=lerp(player.velocity.x,0.0,25*delta)
	if player.velocity.x==0:
		change.emit(self,"Idle")

		
