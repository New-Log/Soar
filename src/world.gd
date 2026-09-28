extends Node2D
var bramble_speed:int=310
var slow_time:float=.2
var new_plats:Array
var new_enemy:enemy
var slow_factor:float = 1
var wall_bumps:Array
var tile_createy:int  = 0
var height_limit:int = -90000
#func _ready() -> void:
	#for y in 5000:
		#$Campaign/map.set_cell(Vector2(15,tile_createy),0,Vector2i(0,0),0)
		#$Campaign/map.set_cell(Vector2(-15,tile_createy),0,Vector2i(0,0),0)
		#wallBump_generate()
		#tile_createy-=1

func start_game():
	$Campaign/map.clear()
	tile_createy=40
	clean_up()
	$"../Title/Control/StartContainer".hide()
	$"../HUD/Control/RespawnContainer".hide()
	Global.create_position=0
	platform.difficulty=6
	platform.event_type=0
	$"../Create".start()
	generate(100)
	$Campaign/bramble.position=Vector2(0,160)
	$player.reset()
	get_tree().paused=false
	$".".show()
#
func _physics_process(delta: float) -> void:

	$player.move(delta)
	if $player.position.y<-10:
		bramble(delta)
	for plat in platform.moving_platforms:
		plat.move(delta)
	#enemy.process(delta)

func generate(times:int):
	$"../TextureRect".size.y+=100
	for i in times:
		new_plats=platform.generate_segment()
		for plat in new_plats:
			$Endless.add_child(plat)
	for i in times*22:
		$Campaign/map.set_cell(Vector2(15,tile_createy),0,Vector2i(0,0),0)
		$Campaign/map.set_cell(Vector2(-15,tile_createy),0,Vector2i(0,0),0)
		tile_createy-=1
		wallBump_generate()


func clean_up():
	platform.moving_platforms=[]
	for plat in get_tree().get_nodes_in_group("platforms"):
		plat.queue_free()
	for enem in get_tree().get_nodes_in_group("enemies"):
		enemy.enemies.erase(enem)
		enem.queue_free()
	for item in fuel.fuel_array:
		item.queue_free() 
		fuel.fuel_array.erase(item)
	#for bump in wall_bumps:
		#$Campaign/map.erase_cell(bump)
		#wall_bumps.erase(bump)

func _on_bramble_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_bramble_body_entered(body: Node2D) -> void:
	if body == $player:
		body.health=0
	elif body is platform or body is fuel:
		if platform.moving_platforms.has(body):
			platform.moving_platforms.erase(body)
		body.queue_free()

func bramble(delta:float):
	$Campaign/bramble.position.y-=bramble_speed * delta * Global.slow_factor
	print($Campaign/map.local_to_map(Vector2(-224,$Campaign/bramble.position.y)))
	$Campaign/map.erase_cell($Campaign/map.local_to_map(Vector2(224,$Campaign/bramble.position.y+16)))
	$Campaign/map.erase_cell($Campaign/map.local_to_map(Vector2(-224,$Campaign/bramble.position.y+16)))
	$Campaign/map.erase_cell($Campaign/map.local_to_map(Vector2(240,$Campaign/bramble.position.y+16)))
	$Campaign/map.erase_cell($Campaign/map.local_to_map(Vector2(-240,$Campaign/bramble.position.y+16)))



func _on_new_pressed() -> void:
	start_game()

func wallBump_generate():
	var place:Vector2i
	if randi_range(1,3)==1:
		place=Vector2i(14,tile_createy)
		$Campaign/map.set_cell(place,0,Vector2i(0,0),0)
		#wall_bumps.append(place)
	if randi_range(1,3)==1:
		place=Vector2i(-14,tile_createy)
		$Campaign/map.set_cell(place,0,Vector2i(0,0),0)
		#wall_bumps.append(place)

func _on_create_timeout() -> void:
	generate(1)
