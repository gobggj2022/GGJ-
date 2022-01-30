class_name ColorReactive
extends Node

onready var clearSprite = $ClearSprite
onready var darkSprite = $DarkSprite
onready var tween = $Tween

onready var gameManager = get_node("/root/GameManager")

const transitionDuration = 0.2

func _ready():
	darkSprite.modulate.a = 0
	gameManager.connect('side_switch', self, '_on_side_update')


func _on_side_update(isDark):
	print_debug(self)
	var enteringSprite = darkSprite if isDark else clearSprite
	var leavingSprite = clearSprite if isDark else darkSprite

	tween.interpolate_property(enteringSprite, "modulate:a", 0.0, 1.0,
			transitionDuration, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.interpolate_property(leavingSprite, "modulate:a", 1.0, 0.0,
			transitionDuration, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	
	tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
