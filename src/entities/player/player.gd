extends CharacterBody2D
var speed:float=300
var jump_speed:int=-100
var gravity:float=.1
var jumps:int=1
var max_jumps:int=1
var health:int=3
var dead:bool=false
var squashed:bool=false
var old_y:int
var destroying:bool=false 
var power_up:int = 0 #number determines what power_up it is. 1 means rocket jump
func move(delta:float):
	#if health==0:
		#die()
	if !is_on_floor():
		velocity.y=lerp(velocity.y,1200.0,gravity*delta*Global.slow_factor)
	if !get_collision_mask_value(1) and velocity.y>-150:
		normalize()
	move_and_slide()


func reset():
	normalize()
	$AnimatedSprite2D.animation="default"
	dead=false
	health=3
	power_up=0
	velocity=Vector2.ZERO
	position=Vector2(0,-8.5)
	modulate=Color.WHITE

func _on_hit_detect_area_entered(area: Area2D) -> void:
	if area is fuel:
		power_up=1
		$AnimatedSprite2D.animation="rocket_jump"
		area.queue_free()
		fuel.fuel_array.erase(area)
		
func _on_hit_detect_body_entered(body: Node2D) -> void:
	if !get_collision_mask_value(1) and body is platform:
		body.queue_free()

func normalize():
	modulate=Color.WHITE
	set_collision_mask_value(1, true)
#func die():
	#Global.died.emit()
	#dead=true
	#get_tree().paused=true
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
