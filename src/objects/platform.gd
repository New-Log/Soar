extends AnimatableBody2D
class_name platform
static var scene:PackedScene = preload("res://src/objects/platform.tscn")

static var gap:int
static var level_gap:int
static var plat_num:int
static var segment_levels:int=3
static var new_platform:platform
static var new_platforms:Array
static var moving_platforms:Array
static var previous_xpos:int=0
static var offset:int
static var new_item
static var space
static var spawn_pos= Vector2(56,0)
static var difficulty:float=6
static var event_type:int
static var new_fuel:fuel #number determines what event will be, 0 is all purple platforms
var start_pos:int
var move_range:int = 100
var speed:int = 100
static func create():
	var new_platform = scene.instantiate()
	return new_platform

func move(delta:float):
	if(abs(global_position.x-start_pos)<move_range):
		global_position.x+=speed*delta
	else:
		speed*=-1
		global_position.x+=speed*delta*4

static func generate_segment():
	new_platforms=[]
	gap=randi_range(330,360)
	Global.create_position-=gap

	plat_num = randi_range(6,8)
	space=400/plat_num+36
	offset=randi_range(0,50)
	previous_xpos=-200
	difficulty-=.01
	difficulty = clamp(difficulty,2,6)
	#new_platform.position.y=Global.create_position
	#new_platform.position.x=randi_range(-100,100)
	#previous_xpos=new_platform.position.x
	#new_platforms.append(new_platform)
	if randi_range(0,1)==1:
		space*=-1
		previous_xpos*=-1
		offset*=-1
	if Global.create_position<-1000 and randi_range(1,9)==1:
		event_type=randi_range(0,1)


	for plat in plat_num:
		new_platform=create()
		new_platform.global_position=Vector2(previous_xpos+offset,Global.create_position)
		if randi_range(1,220)==1:
			new_fuel=fuel.create()
			new_fuel.position=new_platform.position+spawn_pos
			new_platforms.append(new_fuel)
		if event_type==1 or (randf_range(0,difficulty)<=1 and event_type!=1) :
			new_platform.modulate=Color.PURPLE
			new_platform.get_child(3).monitoring = true
		elif randi_range(1,6)==1:
			new_platform.global_rotation_degrees=90
		previous_xpos+=space

			
			#if previous_xpos<=0:
				#new_platform.position.x=randi_range(-165,165+new_platform.position.x)
			#elif previous_xpos>0:
				#new_platform.position.x=randi_range(-165+new_platform.position.x,165)
		if new_platform.global_position.x>200 or new_platform.global_position.x<-200:
			new_platform.queue_free()
		else:
			new_platforms.append(new_platform)

	return new_platforms


func _on_dash_down_body_entered(body: Node2D) -> void:
	if body.name=="player":
		body.velocity.y=1200
	
