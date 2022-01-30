extends Menu

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var playButton = $ColorRect/PlayButton
onready var creditsButton = $ColorRect/CreditsButton
onready var exitButton = $ColorRect/ExitButton
onready var logo = $ColorRect/LogoReverse

onready var music: AudioStreamPlayer = $MusicMenu

var buttonsLeaveDuration = 0.8

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	playButton.grab_focus()

func play():
	var tween = $Tween
	spriteLeave(logo, tween, 0.4)
	buttonLeave(playButton, tween, 0.2)
	buttonLeave(creditsButton, tween, 0.1)
	buttonLeave(exitButton, tween)


	tween.interpolate_property(self, "modulate:a", 1.0, 0.0,
			buttonsLeaveDuration - 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.6)

	tween.interpolate_property(music, "volume_db", music.volume_db, -80.0,
			buttonsLeaveDuration - 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.6)

	tween.start()

func buttonLeave(button, tween, delay = 0):
	var initialPosition = button.rect_position
	var targetPosition = initialPosition
	targetPosition.x = -button.rect_size.x - 50
	tween.interpolate_property(button, 'rect_position', initialPosition, targetPosition, buttonsLeaveDuration, Tween.TRANS_QUART, Tween.EASE_IN, delay)

func spriteLeave(sprite, tween, delay = 0):
	var initialPosition = sprite.position
	var targetPosition = initialPosition
	targetPosition.x = -sprite.get_rect().size.x - 50
	tween.interpolate_property(sprite, 'position', initialPosition, targetPosition, buttonsLeaveDuration, Tween.TRANS_QUART, Tween.EASE_IN, delay)
				
func exit():
	get_tree().quit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_ExitButton_pressed():
	exit()

func _on_PlayButton_pressed():
	play()


func _on_Tween_tween_all_completed():
	music.stop()
	get_tree().paused = false
	hide()


func _on_PlayButton_mouse_exited():
	pass # Replace with function body.
