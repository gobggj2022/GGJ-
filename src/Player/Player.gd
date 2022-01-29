extends KinematicBody2D

export (int) var run_speed = 100
export (int) var jump_speed = -400
export (int) var gravity = 1200

onready var sprite = $AnimatedSprite

enum {IDLE, RUN, JUMP}
var velocity = Vector2()
var state: int
var anim: String
var new_anim: String

func _ready():
	sprite.play('idle')

func change_state(new_state):
	state = new_state
	match state:
		IDLE:
			new_anim = 'idle'
		RUN:
			new_anim = 'run'
		JUMP:
			new_anim = 'jump'
	sprite.play(new_anim)

func get_input():
	velocity.x = 0
	var jump = Input.is_action_just_pressed('ui_up')
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')

	var isJump = state == JUMP

	if jump and is_on_floor():
		change_state(JUMP)
		velocity.y += jump_speed
	elif right:
		velocity.x += run_speed
		if not isJump: change_state(RUN)
	elif left:
		velocity.x -= run_speed
		if not isJump: change_state(RUN)
	elif not isJump: change_state(IDLE)
	
	if not sprite.flip_h and velocity.x < 0:
		sprite.flip_h = true
	if sprite.flip_h and velocity.x > 0:
		sprite.flip_h = false

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if state == JUMP and is_on_floor() and velocity.y > 0:
			change_state(IDLE)
	velocity = move_and_slide(velocity, Vector2(0, -1))
