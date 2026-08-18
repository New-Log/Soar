extends State
class_name Dash_Down

@export var player:CharacterBody2D
var dash_speed=900


func enter():
	player.velocity.y=dash_speed

func physics_update(delta:float):
	change.emit(self,"Idle")
