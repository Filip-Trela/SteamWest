extends Node2D


var skip_time = 0.5
var timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = get_tree().get_nodes_in_group("Timer")[0]



func skip_function():
	timer.start(skip_time)



func _on_touch_area_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			skip_function()
