extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _on_ArriveeBlanc_player_enter():
	get_node('/root/GameManager').turnDark()
