extends State
class_name Rocket_Jump
var speed=-900
@export var player:CharacterBody2D
func physics_update(delta:float):
	player.modulate=Color.RED
	$"../../AnimatedSprite2D".animation="default"
	player.velocity.y=speed
	player.power_up=0
	$"../..".set_collision_mask_value(1, false)
	change.emit(self,"Idle")
