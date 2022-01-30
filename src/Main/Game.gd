extends Node

onready var _mainMenu = $Interface/MainMenu
onready var _pauseMenu = $Interface/PauseMenu
onready var _gameOverMenu = $Interface/GameOver
onready var _gameWinMenu = $Interface/WinMenu

var isDark = false

signal side_switch(isDark)

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

func gameOver():
	# get_tree().paused = true
	_gameOverMenu.open()

func _on_PauseMenu_restart_level():
	restartCurrentLevel()

func turnDark():
	if (!isDark):
		isDark = true
		_updateStatus()

func turnClear():
	if (isDark):
		isDark = false
		_updateStatus()

func toggle():
	if (isDark):
		isDark = !isDark
		_updateStatus()

func _updateStatus():
	emit_signal('side_switch', isDark)

func _on_Level_game_over():
	gameOver()


func _on_Level_game_win():
	_gameWinMenu.open()
