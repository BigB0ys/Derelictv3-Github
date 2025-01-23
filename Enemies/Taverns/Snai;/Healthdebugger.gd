extends Label

@export var character : CharacterBody2D
@export var statemachine : Character_State_Machine
func _process(delta):
	text = ("State : " + str (statemachine.current_state.name))
