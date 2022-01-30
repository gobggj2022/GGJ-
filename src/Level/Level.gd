extends Node2D

var ghostPlayerNode = preload("res://src/Player/GhostPlayer.tscn")
var ghostPlayer: GhostPlayer

var transitionDuration = 1.0

onready var player: Player = $Player
onready var gameManager = get_node('/root/GameManager')

onready var musicNormal = $MusicNormal
onready var musicReverse = $MusicReverse
onready var transitionEffect = $TransitionEffect

onready var tween = $Tween

func _ready():
	gameManager.connect('side_switch', self, '_on_side_update')

var playerArrivedSecondSocle = false # Go trip
var playerReturnedFirstSocle = false # Back trip

func _on_ArriveeBlanc_player_enter():
	if playerArrivedSecondSocle:
		return

	playerArrivedSecondSocle = true
	get_node('/root/GameManager').turnDark()

	player.saveRecord()
	player.can_record = false

	ghostPlayer = ghostPlayerNode.instance()
	ghostPlayer.global_position = $StartPosition.position
	ghostPlayer.scale = Vector2(0.09,0.09)
	add_child(ghostPlayer)

func _on_ArriveeBlanc_player_leave():
	ghostPlayer.can_get_recording = true

func _on_ArriveeBlanc_ghost_enter():
	player.die()


func _on_DepartBlanc_player_leave():
	player.can_record = true

func _on_DepartBlanc_ghost_enter():
	pass # Replace with function body.

func _on_side_update(isDark):
	var enteringMusic = musicReverse if isDark else musicNormal
	var leavingMusic = musicNormal if isDark else musicReverse

	tween.interpolate_property(enteringMusic, "volume_db", -80.0, 0.0,
			transitionDuration, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)

	tween.interpolate_property(leavingMusic, "volume_db", 0.0, -80.0,
			transitionDuration, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)

	transitionEffect.play()

	tween.start()
func _on_Player_player_died():
	pass # Replace with function body.
