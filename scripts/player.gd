extends CharacterBody2D
@onready var riff = $"../elphaba/AudioStreamPlayer2D"

const SPEED = 150.0
const JUMP_VELOCITY = -350.0
var DEFYING_GRAVITY = 1

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY * DEFYING_GRAVITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("walk_left", "walk_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
		
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("walk")
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("PeePeePooPoo"): 
		print("STOP STEPPING ON ME")
		DEFYING_GRAVITY = 3
	pass # Replace with function body.

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("PeePeePooPoo"): 
		print("AAAAAAAAAAAA")
		DEFYING_GRAVITY = 1
		riff.playing = true
		# play audio 
	pass # Replace with function body.
