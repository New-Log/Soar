extends Node

func _ready() -> void:
	Global.connect("died", on_death)
	Global.connect("respawn", on_respawn)
	get_tree().paused=true

func _on_play_pressed() -> void:
	$Title/Control/TitleContainer.hide()
	$Title/Control/StartContainer.show()

func on_death():
	$HUD/Control/RespawnContainer.show()
	$Create.stop()

func on_respawn() -> void:
	$world.start_game()
