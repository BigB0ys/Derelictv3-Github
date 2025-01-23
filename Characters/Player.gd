extends CharacterBody2D

class_name Player

@export var speed = 250.0
@onready var gun_animations = $Player3Torso/Player3Gun/Gun_Anim_Player
@onready var animation_player = $AnimationPlayer
@onready var state_machine : Character_State_Machine = $PlayerStateMachine
@onready var gun = $Player3Torso/Player3Gun
@onready var head = $Player3Torso/Player3Head
const PROJECTILE = preload("res://Characters/Projectiles/Bullet/bullet.tscn")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var barrel = $Player3Torso/Player3Gun/Barrel
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta 
		
	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("Left", "Right","Lookup", "Lookdown")
	if direction and state_machine.if_can_move():
		if direction.x > 0 and scale.y == 1 or direction.x <0 and scale.y ==-1:
			velocity.x= direction.x * speed
		else:
			velocity.x= (direction.x * 200)/1.5
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if Input.is_action_just_pressed("Shoot"):
		shoot()
		
	move_and_slide()
	update_animation()
	aim(get_global_mouse_position())
	look_at_cursor(get_global_mouse_position())
	
func update_animation():
	if is_on_floor():
		if (velocity.x > 0 and scale.y == 1) or (velocity.x < 0 and scale.y == -1):
			animation_player.play("Run")
		elif (velocity.x < 0 and scale.y ==1 ) or (velocity.x > 0 and scale.y == -1):
			animation_player.play("Backstep")
		else:
			animation_player.play("Idle")
	else:
		if velocity.y > 0:
			animation_player.play ("fall")
		elif velocity.y < 0:
			animation_player.play ("Jump")
			animation_locked = true
		animation_locked = false
	if Input.is_action_just_pressed("Shoot"):
		gun_animations.play("Shoot")

func flip_sprite(val: bool):
	if val == true:
		scale.y=-1
		rotation_degrees=180
	if val == false:
		scale.y=1
		rotation_degrees=0

func aim(pos: Vector2):
	if  (pos.x - self.global_position.x>=10 or pos.x - self.global_position.x <=-10):
		flip_sprite(pos.x < self.global_position.x)
		gun.look_at(pos)

func look_at_cursor(position: Vector2):
	if position.y - self.global_position.y < -50:
		head.frame = 2
	elif position.y - self.global_position.y > 25:
		head.frame = 1
	else:
		head.frame= 0
	
func shoot():
	var new_projectile = PROJECTILE.instantiate()
	
	get_tree().root.add_child(new_projectile)
	new_projectile.global_position = barrel.global_position
	new_projectile.global_rotation = barrel.global_rotation
	
	
