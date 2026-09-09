extends State
class_name Rocket_Jump
#var speed=-900
#@export var player:CharacterBody2D
#func physics_update(delta:float):
	#player.velocity.y=speed
	#player.destroying=true
	#player.collected=0
	#player.modulate=Color.WHITE
	#change.emit(self,"Idle")
