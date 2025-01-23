extends State

@export var animations : AnimationPlayer
@export var cooldown : float = 0.6
@export var return_state : State
@export var speed : float = 15.0
@export var effects : AnimatedSprite2D 
@onready var timer : Timer = $Timer


func on_enter():
	animations.play("Hit")
	player.position.x += player.knockback_direction.x * speed
	effects.play("Blood")
	timer.start(cooldown)	

func state_process(delta):
	#player.velocity.x = player.knockback_direction.x * speed
	#player.move_and_slide()
	pass

func _on_timer_timeout():
	timer.stop()
	next_state = return_state
