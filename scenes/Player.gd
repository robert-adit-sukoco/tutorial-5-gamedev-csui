extends KinematicBody2D

export (int) var speed = 400
export (int) var GRAVITY = 1200
export (int) var jump_speed = -600


const UP = Vector2(0,-1)

var velocity = Vector2()

onready var animation : AnimatedSprite = $AnimatedSprite
onready var dash_cooldown_timer : Timer = $DashCooldownTimer
var dash_ready = true
var dash_cooldown_duration_sec = 5

var double_jump_available = true

func _ready():
	dash_cooldown_timer.set_wait_time(dash_cooldown_duration_sec)
	animation.play("idle")

func get_input():
	velocity.x = 0
	
	
	if not is_on_floor():
		animation.play("jump")
	else:
		double_jump_available = true
		
	if Input.is_action_pressed("sprint"):
		speed = 800
	else:
		speed = 400
	
	if Input.is_action_pressed('right'):
		if is_on_floor():
			animation.play("walk")
		animation.flip_h = false
		
		velocity.x += speed
	
	elif Input.is_action_pressed('left'):
		if is_on_floor():
			animation.play("walk")
		animation.flip_h = true
		
		velocity.x -= speed
	elif is_on_floor():
		animation.play("idle")
	
	
	if is_on_floor() and Input.is_action_just_pressed('up'):
		
		animation.play("jump")
		velocity.y = jump_speed
	
	elif double_jump_available and Input.is_action_just_pressed('up'):
		velocity.y = jump_speed
		double_jump_available = false 
	

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)



func _on_DashCooldownTimer_timeout():
	dash_cooldown_timer.set_wait_time(dash_cooldown_duration_sec)
	pass # Replace with function body.
