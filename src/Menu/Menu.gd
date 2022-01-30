class_name Menu
extends Control

onready var hoverSound = $Hoversound
onready var pressSound = $Clicksound

func _ready():
	bind_buttons(self)



func bind_buttons(node):
	for N in node.get_children():
		if N.get_child_count() > 0:
			bind_buttons(N)
		else:
			if N is BaseButton:
				N.connect('mouse_entered', self, 'button_hover')
				N.connect('focus_entered', self, 'button_hover')
				N.connect('pressed', self, 'button_press')
				

func button_hover():
	hoverSound.play()
func button_press():
	pressSound.play()
