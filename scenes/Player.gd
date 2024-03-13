extends KinematicBody2D

export (int) var speed = 400
export (int) var GRAVITY = 1200
export (int) var jump_speed = -600


const UP = Vector2(0,-1)

onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer
onready var attack_sound = preload("res://assets/audio/attack-sound.wav")

var velocity = Vector2()

onready var animation : AnimatedSprite = $AnimatedSprite
var double_jump_available = true
var is_attacking = false

func _ready():
	audio_player.stream = attack_sound
	animation.play("idle")

func get_input():
	velocity.x = 0
	
	if Input.is_action_just_pressed("attack") and is_on_floor() and not is_attacking:
		is_attacking = true
		animation.play("attack")
		audio_player.play()
	
	if not is_on_floor():
		animation.play("jump")
	else:
		double_jump_available = true
		
	if Input.is_action_pressed("sprint"):
		speed = 800
	else:
		speed = 400
	
	if Input.is_action_pressed('right') and not is_attacking:
		if is_on_floor():
			animation.play("walk")
		animation.flip_h = false
		
		velocity.x += speed
	
	elif Input.is_action_pressed('left') and not is_attacking:
		if is_on_floor():
			animation.play("walk")
		animation.flip_h = true
		
		velocity.x -= speed
	elif is_on_floor() and not is_attacking:
		animation.play("idle")
	
	
	if is_on_floor() and Input.is_action_just_pressed('up') and not is_attacking:
		
		animation.play("jump")
		velocity.y = jump_speed
	
	elif double_jump_available and Input.is_action_just_pressed('up'):
		velocity.y = jump_speed
		double_jump_available = false 
	

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)



func _on_AnimatedSprite_animation_finished():
	is_attacking = false
	animation.play("idle")
