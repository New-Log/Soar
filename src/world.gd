extends Node2D
var bramble_speed:int=300
var slow_time:float=.2
var new_plats:Array
var new_enemy:enemy
var slow_factor:float = 1

func _ready() -> void:
	pass

func start_game():
	clean_up()
	$"../Title/Control/StartContainer".hide()
	$"../HUD/Control/RespawnContainer".hide()
	Global.create_position=0
	generate(200)
	wallBump_generate()
	$Campaign/bramble.position=Vector2(0,160)
	$player.dead=false
	$player.health=3
	$player.velocity=Vector2.ZERO
	$player.position=Vector2(0,-8.5)
	get_tree().paused=false
	$".".show()
#
func _physics_process(delta: float) -> void:

	$player.move(delta)
	if $player.position.y<-10:
		bramble(delta)
	#enemy.process(delta)

func generate(times:int):
	for i in times:
		new_plats=platform.generate_segment()
		for plat in new_plats:
			$Endless.add_child(plat)

func clean_up():
	for plat in get_tree().get_nodes_in_group("platforms"):
		plat.queue_free()
	for enem in get_tree().get_nodes_in_group("enemies"):
		enemy.enemies.erase(enem)
		enem.queue_free()

func _on_bramble_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_bramble_body_entered(body: Node2D) -> void:
	if body == $player:
		body.health=0
	elif body is platform:
		body.queue_free()

func bramble(delta:float):
	$Campaign/bramble.position.y-=bramble_speed * delta * Global.slow_factor


func _on_new_pressed() -> void:
	start_game()

func wallBump_generate():
	var place:Vector2i
	for i in 100:
		place=Vector2i(14,randi_range(-1000,0))
		$Campaign/map.set_cell(place,0,Vector2i(0,0),0)
	for i in 100:
		place=Vector2i(-14,randi_range(-1000,0))
		$Campaign/map.set_cell(place,0,Vector2i(0,0),0)


#func _on_create_timeout() -> void:
	#generate(1)
