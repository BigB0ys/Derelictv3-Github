extends State

class_name Ground_State


@onready var timer = $Timer

@export var jump_velocity = -350.0
@export var air_state : State
var jump_available : bool = true
@export var jump_time : float = 0.1


func state_process(delta):
	if not player.is_on_floor():
		if jump_available:
			if timer.is_stopped():
				timer.start(jump_time)
		else:
			next_state=air_state
	else:
		jump_available = true
		timer.stop()

func state_input (event : InputEvent):
	if event.is_action_pressed("Jump"):
		jump()
		jump_available= false

func jump():
	if jump_available:
		player.velocity.y = jump_velocity
		next_state = air_state

func coyote_timeout():
	jump_available = false 


