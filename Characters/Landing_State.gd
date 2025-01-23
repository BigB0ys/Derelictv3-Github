extends State

class_name Landing_State

@export var ground_state : State

func state_process(delta):
	if player.is_on_floor():
		next_state = ground_state
		
