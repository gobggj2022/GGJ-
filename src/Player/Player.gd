extends KinematicBody2D

export (int) var run_speed = 100
export (int) var jump_speed = -400
export (int) var dash_speed = 1000
export (int) var dash_time = 0.01 # in seconds
export (int) var gravity = 1200

onready var sprite = $AnimatedSprite
onready var dashTimer: Timer = $DashTimer
onready var sneakHitbox: CollisionShape2D = get_node("SneakCollisionShape2D")
onready var normalHitbox: CollisionShape2D = get_node("CollisionShape2D")

enum {IDLE, RUN, JUMP, DASH, SNEAK, DEAD}
var velocity = Vector2()
var state: int
var anim: String
var new_anim: String

func _ready():
	sprite.play('idle')

func change_state(new_state):
	if new_state != SNEAK:
		sneakHitbox.disabled = true
		normalHitbox.disabled = false
	state = new_state
	match state:
		IDLE:
			new_anim = 'idle'
		RUN:
			new_anim = 'run'
		JUMP:
			new_anim = 'jump'
		DASH:
			new_anim = 'dash'
		SNEAK:
			new_anim = 'sneak'
		DEAD:
			new_anim = 'death'
	sprite.play(new_anim)

func get_input():
	velocity.x = 0
	var jump = Input.is_action_just_pressed('ui_up')
	var dash = Input.is_action_just_pressed('ui_select') or dashTimer.time_left != 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var down = Input.is_action_pressed('ui_down')

	var isJump = state == JUMP
	var isDash = state == DASH

	if jump and is_on_floor():
		change_state(JUMP)
		velocity.y += jump_speed
	elif dash:
		if dashTimer.time_left != 0:
			print(dashTimer.time_left)
			if sprite.flip_h:
				velocity.x -= dash_speed
			else:
				velocity.x += dash_speed
		else:
			dash()
	elif down:
		change_state(SNEAK)
		sneakHitbox.disabled = false
		normalHitbox.disabled = true
	elif right:
		velocity.x += run_speed
		if not isJump: change_state(RUN)
	elif left:
		velocity.x -= run_speed
		if not isJump: change_state(RUN)
	elif not isJump and not isDash: change_state(IDLE)
	
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

func dash():
	change_state(DASH)
	dashTimer.wait_time = 0.2
	dashTimer.start()

	

func _on_DashTimer_timeout():
	change_state(RUN)
	
