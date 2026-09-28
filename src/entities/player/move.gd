extends State
class_name Move

@export var player:CharacterBody2D
var speed:float=450
var time_held_rocket:float=0
const dash_delay = .25
var time_held_dash:float=dash_delay

var last_event:int = 0 #0 means no event, 1 means left, 2 means right


func physics_update(delta:float):
	time_held_dash-=delta
	#if Input.is_action_just_released("jump"):
		#player.velocity.y=player.old_y
		#Global.slow_factor=1
	if player.health<=0:
		change.emit(self,"Dead")
	if Input.is_action_just_pressed("jump"):
		if player.is_on_floor() or ($"../../ShapeCast2D".is_colliding() and $"../../ShapeCast2D".get_collider(0).global_rotation_degrees==90):
			change.emit(self,"Jump")
		#elif Input.is_action_pressed("jump") and player.power_up==1:
			#change.emit(self,"Rocket_Jump")
	if Input.is_action_pressed("jump") and player.power_up==1:
		time_held_rocket+=delta
	if Input.is_action_just_released("jump"):
		if time_held_rocket>.3:
			change.emit(self,"Rocket_Jump")
		time_held_rocket=0
		#player.old_y=player.velocity.y
	#if Input.is_action_pressed("jump") and player.time_juice>0 and player.is_on_floor():
		#Global.slow_factor=.1
	#elif Input.is_action_pressed("jump") and player.time_juice>0:
		#player.time_juice-=1*delta
		#Global.slow_factor=.1

	if Input.is_action_just_pressed("dash_down"):
		change.emit(self,"Dash_Down")
	#if Input.is_action_just_pressed("rocket") and player.collected==3:
		#change.emit(self,"Rocket_Jump")
	#elif Input.is_action_just_pressed("left"):
		#print(last_event)
		#if last_event==1 and time_held_dash>=0:
			#player.velocity.x=-1000
			#player.velocity.y = clamp(player.velocity.y,-10000000,0)
			#player.velocity.y+=-180
			#last_event=0
		#else:
			#last_event=1
		#time_held_dash=dash_delay

	elif Input.is_action_pressed("left"):
		player.velocity.x=lerp(player.velocity.x,-speed,10*delta)


	#elif Input.is_action_just_pressed("right"):
		#print(last_event)
		#if last_event==2 and time_held_dash>=0:
			#player.velocity.x=1000
			#player.velocity.y = clamp(player.velocity.y,-10000000,0)
			#player.velocity.y+=-180
			#last_event=0
		#else:w
			#last_event=2
		#time_held_dash=dash_delay
		
	elif Input.is_action_pressed("right"):
		player.velocity.x=lerp(player.velocity.x,speed,10*delta)
	
	else:
		player.velocity.x=lerp(player.velocity.x,0.0,25*delta)
	
	if player.velocity.x==0:
		change.emit(self,"Idle")
	if Input.is_action_just_pressed("god"):
		change.emit(self,"God")

		
