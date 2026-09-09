extends State
class_name God
@export var player:CharacterBody2D

func enter():
	player.get_child(0).disabled=true

func physics_update(delta:float):
	player.velocity=Vector2.ZERO
	if Input.is_action_pressed("jump"):
		player.velocity.y=-8000
	if Input.is_action_pressed("left"):
		player.velocity.x=-player.speed
	if Input.is_action_pressed("right"):
		player.velocity.x=player.speed
	if Input.is_action_pressed("dash_down"):
		player.velocity.y=4000
	if Input.is_action_just_pressed("god"):
		change.emit(self,"Idle")

func exit():
	player.get_child(0).disabled=false
