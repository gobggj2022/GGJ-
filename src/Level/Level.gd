extends Node2D

var ghostPlayerNode = preload("res://src/Player/GhostPlayer.tscn")
var ghostPlayer: GhostPlayer

onready var player: Player = $Player

func _on_ArriveeBlanc_player_enter():
	get_node('/root/SideManager').turnDark()

	player.saveRecord()
	player.can_record = false

	ghostPlayer = ghostPlayerNode.instance()
	ghostPlayer.global_position = $StartPosition.position
	ghostPlayer.scale = Vector2(0.09,0.09)
	add_child(ghostPlayer)

func _on_ArriveeBlanc_player_leave():
	ghostPlayer.can_get_recording = true


func _on_DepartBlanc_player_leave():
	player.can_record = true

