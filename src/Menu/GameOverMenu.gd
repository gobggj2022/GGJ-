extends Menu

onready var gameManager = get_node('/root/Game')

signal restart_level()

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func open():
	$ColorRect/RestartButton.grab_focus()
	# get_tree().paused = true;
	show();

func close():
	get_tree().paused = false;
	hide();


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RestartButton_pressed():
	close()
	gameManager.turnClear()
	emit_signal('restart_level')

