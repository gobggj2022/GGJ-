class_name Socle
extends ColorReactive

signal player_enter()
signal player_leave()

func _on_StepCollision_body_exited(body:Node):
	if body is Player:
		emit_signal('player_leave')

func _on_StepCollision_body_entered(body:Node):
	if body is Player:
		emit_signal('player_enter')
