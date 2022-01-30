class_name Socle
extends ColorReactive

signal player_enter()
signal player_leave()

signal ghost_enter()
signal ghost_leave()

func _on_StepCollision_body_exited(body):
	if body is Player:
		emit_signal('player_leave')
	if body is GhostPlayer:
		emit_signal("ghost_leave")

func _on_StepCollision_body_entered(body):
	if body is Player:
		emit_signal('player_enter')
	if body is GhostPlayer:
		emit_signal("ghost_enter")
