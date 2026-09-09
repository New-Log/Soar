extends State
class_name Dead

@export var player:CharacterBody2D
var sent:bool=false

func enter():
	Global.died.emit()
	player.dead=true
	get_tree().paused=true
	sent=false

func physics_update(delta:float):
	if player.health>0:
		change.emit(self,"Idle")
	if Input.is_action_just_pressed("jump") and sent==false:
		sent=true
		Global.respawn.emit()
	
		
