extends CharacterBody2D
var speed:float=300
var jump_speed:int=-100
var gravity:float=.1
var jumps:int=1
var max_jumps:int=1
var health:int=3
var dead:bool=false
var squashed:bool=false
var time_juice:int = 100
var old_y:int
func move(delta:float):
	velocity.y*=Global.slow_factor
	print(velocity.y)
	if health==0:
		die()
	if !is_on_floor():
		velocity.y=lerp(velocity.y,1200.0,gravity*delta*Global.slow_factor)
	else:
		time_juice=100
	move_and_slide()
	
func die():
	Global.died.emit()
	dead=true
	$state_machine.force_update("Dead")
	get_tree().paused=true
#func move(delta:float):
	#if dead!=true:
		#if Input.is_action_pressed("left"):
			#velocity.x=lerp(velocity.x,-speed,15*delta)
		#elif Input.is_action_pressed("right"):
			#velocity.x=lerp(velocity.x,speed,15*delta)
		#else:
			#velocity.x=lerp(velocity.x,0.0,25*delta)
#
		#if Input.is_action_just_pressed("jump") and jumps>0 and is_on_floor():
			#jumps-=1
			#velocity.y=jump_speed
		#if Input.is_action_just_pressed("jump") and !is_on_floor():
			#pass
		#if Input.is_action_just_pressed("dash_down"):
			#velocity.y=1000
		#if is_on_floor():
			#jumps=max_jumps
		##elif is_on_wall():
			##jumps=max_jumps
			##velocity.y+=gravity/2*delta
		#else:
			#jumps=0
			#velocity.y=lerp(velocity.y,1200.0,gravity*delta)
		##print(velocity)
		#move_and_slide()



#func squash(delta:float):
	#if $AnimatedSprite2D.scale.y<=11.01 or ($AnimatedSprite2D.scale.y<11.99 and squashed==true):
		#squashed=true
		#$AnimatedSprite2D.scale.y=lerp($AnimatedSprite2D.scale.y,12.0,10*delta)
		#$AnimatedSprite2D.scale.x=lerp($AnimatedSprite2D.scale.x,12.0,10*delta)
	#else:
		#squashed=false
		#$AnimatedSprite2D.scale.y=lerp($AnimatedSprite2D.scale.y,11.0,10*delta)
		#$AnimatedSprite2D.scale.x=lerp($AnimatedSprite2D.scale.x,13.0,10*delta)
		#print($AnimatedSprite2D.scale.y)
