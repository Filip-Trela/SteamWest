extends Label

var turn = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Turn " + str(turn)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func next_turn():
	turn += 1
	text = "Turn " + str(turn)
	
	
	
	
