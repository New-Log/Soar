extends State
class_name Dead

@export var player:CharacterBody2D

func physics_update(delta:float):
	if player.health>0:
		change.emit(self,"Idle")
	if Input.is_action_just_pressed("jump"):
		Global.respawn.emit()
	
		
