extends KinematicBody2D

onready var sprite = $AnimatedSprite

var load_data : Dictionary = Dictionary()
var count = 0

func _ready():
	load_data = load_file()
	pass

func load_file():
	var f := File.new()
	if f.file_exists("res://record.json"):
		f.open("res://record.json", File.READ)
		var result := JSON.parse(f.get_as_text())
		f.close()
		return result.result as Dictionary
	return Dictionary()
	
func _physics_process(_delta):
	get_recording()
	pass
	
func get_recording():
	count += 1
	var test = load_data.get(String(count))
	if(test != null):
		print(test[1])
		sprite.play(test[0])
		global_position = str2var("Vector2" + test[1])
		sprite.flip_h = test[2]

# TODO : Connect signal
func _on_door_passed():
	pass

	
# DEPRECATED
var reverse_count = -1;

func get_reverse_recording():
	reverse_count -= 1
	var test = load_data.get(String(reverse_count))
	if(test != null):
		print(test[1])
		sprite.play(test[0])
		global_position = str2var("Vector2" + test[1])
		sprite.flip_h = test[2]