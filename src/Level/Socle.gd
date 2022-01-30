class_name Socle
extends ColorReactive

signal player_enter()
signal player_leave()

func _on_StepCollision_body_exited(body):
	if body is Player:
		emit_signal('player_leave')

func _on_StepCollision_body_entered(body):
	if body is Player:
		emit_signal('player_enter')
