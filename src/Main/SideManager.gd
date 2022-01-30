extends Node

var isDark = false

signal side_switch(isDark)

func _ready():
	print("hey")

func turnDark():
	isDark = true
	_updateStatus()

func _updateStatus():
	emit_signal('side_switch', isDark)


