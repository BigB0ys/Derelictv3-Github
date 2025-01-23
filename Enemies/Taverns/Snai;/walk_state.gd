extends State

@export var animations : AnimationPlayer
@export var speed : float = 30.0

var direction = Vector2.LEFT

func state_process(delta):
	animations.play("Slide")
	player.velocity.x = direction.x * speed * player.scale.y
	player.move_and_slide()
