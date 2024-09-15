extends Node2D


var entity_name

func _ready() -> void:
	$Name.text = entity_name

func _on_off_area_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			queue_free()
