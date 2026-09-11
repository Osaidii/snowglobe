extends CharacterBody2D

@export_category("Instance")
@export var CONTROLS := 1
@export var OUTFIT := 1
@export_category("Stats")
@export var NORMAL_SPEED := 200
@export var TAGGER_SPEED := 300
@export var JUMP_VELOCITY = -300.0
@export_category("Data")
@export var IS_TAGGER := false

# Outfits
@onready var outfit_1: AnimatedSprite2D = $"Outfit 1"
@onready var outfit_2: AnimatedSprite2D = $"Outfit 2"

var animation: AnimatedSprite2D
var direction: float

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Set Outfit
	if OUTFIT == 1:
		animation = outfit_1
		outfit_2.visible = false
	elif OUTFIT == 2:
		animation = outfit_2
		outfit_1.visible = false
	
	# Jump
	if (Input.is_action_just_pressed("up1") and CONTROLS == 1) or (Input.is_action_just_pressed("up2") and CONTROLS == 2):
		jump()
	
	# Movement
	if CONTROLS == 1:
		direction = Input.get_axis("left1", "right1")
	elif CONTROLS == 2:
		direction = Input.get_axis("left2", "right2")
	if direction:
		if IS_TAGGER:
			velocity.x = direction * TAGGER_SPEED
		elif !IS_TAGGER:
			velocity.x = direction * NORMAL_SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, 1200 * delta)
	move_and_slide()
	
	# Turn
	face_direction()
	
	# Animations
	anims()

# This function flips sprite based on direction.
func face_direction() -> void:
	if direction > 0:
		animation.flip_h = false
	elif direction < 0:
		animation.flip_h = true

# This function plays the animation.
func anims() -> void:
	if !is_on_floor():
		animation.play("jump")
	elif velocity.x != 0:
		animation.play("run")
	else:
		animation.play("idle")

# This function makes the player jump.
func jump() -> void:
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
