extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _mainMenu = $Interface/MainMenu
onready var _pauseMenu = $Interface/PauseMenu


func restartCurrentLevel():
	$Level.get_tree().reload_current_scene()

func _unhandled_input(event):
	# The GlobalControls node, in the Stage scene, is set to process even
	# when the game is paused, so this code keeps running.
	# To see that, select GlobalControls, and scroll down to the Pause category
	# in the inspector.
	if event.is_action_pressed("toggle_pause"):
		var tree = get_tree()
		tree.paused = not tree.paused
		if tree.paused:
			_pauseMenu.open()
		else:
			_pauseMenu.close()
		get_tree().set_input_as_handled()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PauseMenu_restart_level():
	restartCurrentLevel()
