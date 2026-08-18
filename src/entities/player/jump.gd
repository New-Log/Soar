extends State
class_name Jump

@export var player:CharacterBody2D
@export var jump_speed:int
@export var gravity:float

func enter():
	player.velocity.y=jump_speed

func physics_update(delta:float):
	change.emit(self,"Idle")
