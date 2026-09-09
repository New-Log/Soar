extends Area2D
class_name enemy
static var speed=100
static var enemies:Array
static var scene:PackedScene= preload("res://src/entities/enemy.tscn")
static var new_enemy
var home:Vector2
var on_screen:bool=false
static func create():
	new_enemy=scene.instantiate()
	enemies.append(new_enemy)
	return new_enemy

static func process(delta: float):
	for enem in enemies:
		enem.move(delta)

#
func move(delta:float):
	if on_screen:
		position.x+=speed*delta
		if home.distance_to(position)>35:
			speed*=-1
			#$RayCast2D.global_rotation_degrees+=225*(abs(speed)/speed)

func _on_body_entered(body: Node2D) -> void:
	if body.name=="player":
		if body.velocity.y==0:
			die()
		else:
			body.die()

func die():
	$CollisionShape2D.set_deferred("disabled",true)
	enemies.erase(self)
	modulate=Color.BLACK
	await get_tree().create_timer(1).timeout
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	on_screen=true

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	on_screen=false
