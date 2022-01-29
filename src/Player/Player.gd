extends KinematicBody2D

export (int) var run_speed = 100
export (int) var jump_speed = -400
export (int) var gravity = 1200

enum {IDLE, RUN, JUMP}
var velocity = Vector2()
var state: int
var anim: String
var new_anim: String

func change_state(new_state):
	state = new_state
	match state:
		IDLE:
			new_anim = 'idle'
		RUN:
			new_anim = 'run'
		JUMP:
			new_anim = 'jump'

func get_input():
	velocity.x = 0
<<<<<<< HEAD

	var jump = Input.is_action_just_pressed('ui_select')
=======
	var jump = Input.is_action_just_pressed('ui_up')
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
>>>>>>> 1571aae4f78529b6939d8266a965f397e2c8c5d7

	if jump and is_on_floor():
		change_state(JUMP)
		velocity.y += jump_speed
	if right:
		change_state(RUN)
		velocity.x += run_speed
	if left:
		change_state(RUN)
		velocity.x -= run_speed
	$Sprite.flip_h = velocity.x < 0

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if state == JUMP and is_on_floor():
			change_state(IDLE)
	velocity = move_and_slide(velocity, Vector2(0, -1))
