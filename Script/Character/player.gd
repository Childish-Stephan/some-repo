extends CharacterBody2D

# Variables
@export var speed : float = 200.0
@export var jump_velocity : float = -200.0
@export var gravity : int = 500
@export var double_jump_velocity : float = -150.0
@export var gravityMultiplier : float = 1.5
@export var groundPoundMultiplier : float = 5


var has_double_jumped : bool = false
var animation_locked : bool = false
var is_in_air : bool = false


#Reference direction for entire script
var direction : Vector2 = Vector2.ZERO

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_tree = $AnimationTree


func _ready():
	animation_tree.active = true
	animation_tree.set("parameters/Move/blend_position", direction.x)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		is_in_air = true
		# Handles Falling
		if animated_sprite.animation == "jump_loop":
			velocity.y += (gravity * gravityMultiplier) * delta
		elif Input.is_action_just_pressed("down"):
			velocity.y += (gravity * groundPoundMultiplier)/7
			animated_sprite.play("jump_loop")
			
	else:
		has_double_jumped = false
		if is_in_air == true:
			land()
			is_in_air = false

	# Handles jumping.
	if Input.is_action_just_pressed("jump"): 
		if is_on_floor():
			# Normal jump from floor
			jump()
			
		elif not has_double_jumped:
			# Double jump in air
			double_jump()
			

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("left", "right", "up", "down")
	
	# Stops movement after landing on the ground
	if direction.x != 0:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	
	move_and_slide()
	update_animation()
	update_where_the_sprite_is_facing()

# Locks the player's animation to prevent animation overlap
func update_animation():
	if not animation_locked:
		if not is_on_floor():
			# Handles falling animation
			animated_sprite.play("jump_loop")
		
		else:
			# Handles movement animation 
			if direction.x != 0:
				animated_sprite.play("run")
		
			else:
				animated_sprite.play("idle")


func update_where_the_sprite_is_facing():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
		
# Handles jumping from ground
func jump():
	velocity.y = jump_velocity
	animated_sprite.play("jump_start")
	animation_locked = true
	
# Handles landing on ground
func land():
	animated_sprite.play("jump_end")
	animation_locked = true
	
func on_animation_ended():
	# If the animation matches the following and has ended then, unlock the animation
	if (["double_jump", "jump_start", "jump_end"]).has(animated_sprite.animation):
		animation_locked = false
		
func double_jump():
		velocity.y = double_jump_velocity
		animated_sprite.play("double_jump")
		has_double_jumped = true
		animation_locked = true
