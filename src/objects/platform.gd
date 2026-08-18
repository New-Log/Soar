extends AnimatableBody2D
class_name platform
static var scene:PackedScene = preload("res://src/objects/platform.tscn")
static var gap:int
static var level_gap:int
static var plat_num:int
static var segment_levels:int=3
static var new_platform:platform
static var new_platforms:Array
static var previous_xpos:int=0
static var difficulty:int=0
var spawn_pos:Vector2
static var space
static func create():
	var new_platform = scene.instantiate()
	return new_platform

static func generate_segment():
	new_platforms=[]
	previous_xpos=0
	gap=randi_range(120,170)
	Global.create_position-=gap
	plat_num = randi_range(1,3)
	space=330/plat_num+1
	new_platform=create()
	new_platform.position.y=Global.create_position
	new_platform.position.x=randi_range(-100,100)
	previous_xpos=new_platform.position.x
	new_platforms.append(new_platform)

	for plat in plat_num-1:
		new_platform=create()
		new_platform.position.y=Global.create_position
		if randi_range(0,1)==0:
			new_platform.position.x=previous_xpos-space-randi_range(0,50)
		else:
			new_platform.position.x=previous_xpos+space+randi_range(0,50)
		#if previous_xpos<=0:
			#new_platform.position.x=randi_range(-165,165+new_platform.position.x)
		#elif previous_xpos>0:
			#new_platform.position.x=randi_range(-165+new_platform.position.x,165)
		new_platform.spawn_pos=Vector2(new_platform.position.x,new_platform.position.y-10)
		new_platforms.append(new_platform)
	return new_platforms
	
