extends Node2D

var stage_director

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stage_director = get_parent().get_node("Director/StageDirector")


func activate():
	stage_director.next_stage()

func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if not event.pressed:
			activate()
