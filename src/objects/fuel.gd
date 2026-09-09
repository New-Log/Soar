extends Area2D
class_name fuel
static var scene:PackedScene = preload("res://src/objects/fuel.tscn")
static var new_fuel
static var fuel_array:Array

static func create():
	var new_fuel=scene.instantiate()
	return new_fuel
#
#func generate():
	#fuel_array=[]
	
	


func _on_body_entered(body: Node2D) -> void:
	if body.name=="player" and body.collected<3:
		body.collected+=1
		if body.collected==3:
			body.modulate=Color.RED
		queue_free()
