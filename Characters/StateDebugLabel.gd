extends Label


@export var state_machine : Character_State_Machine 

func _process(delta):
	text = "State: " + str(state_machine.current_state.name)
