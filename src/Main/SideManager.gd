extends Node

var isDark = false

signal side_switch(isDark)

func _ready():
	print("hey")

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


