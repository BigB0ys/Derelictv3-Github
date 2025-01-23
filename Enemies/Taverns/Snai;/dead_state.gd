extends State

@export var animations : AnimationPlayer

func on_enter():
	animations.play("Dead")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Dead":
		player.queue_free()
