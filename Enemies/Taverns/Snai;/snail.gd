extends CharacterBody2D

class_name enemy


@export var health : float = 15.0
@export var hit_state : State
@export var dead_state : State

@onready var body : Sprite2D = $SnailArt
@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var wall_sensor : RayCast2D = $Wallsensor
@onready var floor_sensor : RayCast2D = $Floorsensor
@onready var state_machine : Character_State_Machine = $Character_State_Machine

@export var speed : float = 45

var knockback_direction : Vector2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	detect_obstacle()


func switch_direction():
	if scale.x == 1:
		scale.x =-1
	elif scale.x == -1:
		scale.x = 1

func detect_obstacle():
	if wall_sensor.is_colliding() or !floor_sensor.is_colliding():
		switch_direction()

func take_damage(damage : float, projectile : Area2D):
	if state_machine.current_state != hit_state:
		health = health - damage
		if projectile.global_position.x < self.global_position.x:
			knockback_direction = Vector2.RIGHT
		else:
			knockback_direction = Vector2.LEFT
		if health <= 0:
			state_machine.current_state.next_state = dead_state
		elif health > 0:
			state_machine.current_state.next_state = hit_state
		
	
