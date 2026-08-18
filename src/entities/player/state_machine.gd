extends Node
@export var start_state:State
var current_state:State
var states:Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name]=child
			child.change.connect(on_change)
	if start_state:
		start_state.enter()
		current_state=start_state 

func _physics_process(delta: float):
	if current_state:
		current_state.physics_update(delta) 

func on_change(state, new_state_name):
	if state!=current_state:
		return
	var new_state = states.get(new_state_name)
	if !new_state:
		return
	if current_state:
		current_state.exit()
	new_state.enter()
	current_state=new_state

func force_update(state):
	var new_state = states.get(state)
	current_state=new_state
