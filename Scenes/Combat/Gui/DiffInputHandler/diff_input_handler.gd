extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	hide_joys()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start(type):
	match type:
		"rotate": 
			$RotateJoy.visible = true
			$RotateJoy["process_mode"] = Node.PROCESS_MODE_INHERIT
		"move": 
			$MoveJoy.visible = true
			$MoveJoy["process_mode"] = Node.PROCESS_MODE_INHERIT
		"null":
			$NullJoy.visible = true
			$NullJoy["process_mode"] = Node.PROCESS_MODE_INHERIT


func hide_joys():
	for child in get_children():
		child.visible = false
		child["process_mode"] = Node.PROCESS_MODE_DISABLED
