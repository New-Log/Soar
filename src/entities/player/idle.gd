extends State
class_name Idle
@export var player:CharacterBody2D
var time_held_rocket:float=0


func physics_update(delta:float):
	if player.health<=0:
		change.emit(self,"Dead")
	#if Input.is_action_just_released("jump"):
		#player.velocity.y=player.old_y
		#Global.slow_factor=1
	if Input.is_action_just_pressed("jump"):
		if player.is_on_floor() or ($"../../ShapeCast2D".is_colliding() and  $"../../ShapeCast2D".get_collider(0).global_rotation_degrees==90):
			change.emit(self,"Jump")
		#elif Input.is_action_pressed("jump") and player.power_up==1:
			#change.emit(self,"Rocket_Jump")

	if Input.is_action_pressed("jump") and player.power_up==1:
		time_held_rocket+=delta
	if Input.is_action_just_released("jump"):
		if time_held_rocket>.3:
			change.emit(self,"Rocket_Jump")
		time_held_rocket=0

	if Input.is_action_just_pressed("dash_down"):
		change.emit(self,"Dash_Down")
	#if Input.is_action_just_pressed("rocket") and player.collected==3:
		#change.emit(self,"Rocket_Jump")
		#player.old_y=player.velocity.y
	#if Input.is_action_pressed("jump") and player.time_juice>0 and player.is_on_floor():
		#Global.slow_factor=.1
	#elif Input.is_action_pressed("jump") and player.time_juice>0:
		#player.time_juice-=1*delta
		#Global.slow_factor=.1
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		change.emit(self,"Move")
	if Input.is_action_just_pressed("god"):
		change.emit(self,"God")
	player.velocity.x=lerp(player.velocity.x,0.0,25*delta)
	
