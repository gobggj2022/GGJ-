class_name GameCamera
extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var targetPosition = position
onready var targetZoom = zoom
var lerpVal = 4
var fenceLeft = 420
var fenceRight = 1220
var fenceBottom = 760

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var amount = lerpVal * delta

	position = lerpVector(position, targetPosition, amount)
	zoom = lerpVector(zoom, targetZoom, amount)


func lerp (val, target, amount):
	return val + ((target - val) * amount)

func lerpVector(vector: Vector2, target: Vector2, amount):
	return Vector2(
		lerp(vector.x, target.x, amount),
		lerp(vector.y, target.y, amount)
	)

func setTargetPosition(newVal: Vector2):
	print(newVal)
	if newVal.x < fenceLeft:
		newVal.x = fenceLeft
	if newVal.x > fenceRight:
		newVal.x = fenceRight
	if newVal.y > fenceBottom:
		newVal.y = fenceBottom
	
	targetPosition = newVal