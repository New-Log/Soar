extends Node
var death_messsage:Array = ["Nobody's Perfect", "Get Higher", "Dead"]
func _ready() -> void:
	Global.connect("died", on_death)
	Global.connect("respawn", on_respawn)
	get_tree().paused=true

func _on_play_pressed() -> void:
	$Title/Control/TitleContainer.hide()
	$Title/Control/StartContainer.show()

func on_death():
	$HUD/Control/RespawnContainer.show()
	#$HUD/Control/RespawnContainer/DeathMessage.text = death_messsage[randi_range(0,death_messsage.size()-1)]
	$Create.stop()

func on_respawn() -> void:
	$world.start_game()
