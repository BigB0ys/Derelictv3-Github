extends State

class_name Air_State

@export var ground_state : State
var jump_buffer : bool = false
@export var jump_velocity = -400.0
@export var jump_buffer_timer : float = 0.1

func state_process(delta):
	if player.is_on_floor() and not jump_buffer:
		next_state = ground_state
	elif player.is_on_floor() and jump_buffer:
		jump()
		

func state_input(event : InputEvent):
	if event.is_action_pressed("Jump"):
		jump_buffer = true
		get_tree().create_timer(jump_buffer_timer).timeout.connect(buffer_timeout)
	elif event.is_action_released("Jump") and player.velocity.y < 0:
		player.velocity.y = jump_velocity/4

	
func jump():
	player.velocity.y = jump_velocity
	jump_buffer = false

func buffer_timeout():
	jump_buffer = false
	
