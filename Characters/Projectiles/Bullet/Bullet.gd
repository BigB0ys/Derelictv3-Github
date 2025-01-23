extends Area2D

@export var bullet_damage : float = 5.0
@export var bulletspeed : float = 300.0
@onready var animations = $AnimatedSprite2D
var direction : Vector2
var distance_travelled : float = 0
var travelling : bool = true
var has_exploded : bool = false

func _process(delta):
	if travelling and distance_travelled <= 1000:
		direction = Vector2.RIGHT.rotated(global_rotation)
		position += direction * bulletspeed * delta
		distance_travelled += 10
	else:
		travelling = false
	update_animation()

func update_animation():
	if travelling:
		animations.play("Flying")
	else:
		animations.play("Explosion")

func _on_body_entered(body):
	if body is Player and not has_exploded:
		travelling=true
	else:
		travelling = false
		has_exploded = true
		global_rotation=0
		if body.has_method("take_damage"):
			body.take_damage(bullet_damage, self)

func _on_explosion_finished():
	queue_free()
