extends Node2D

var area_input
var pressed
var dragging

func _input(event):
	if event is InputEventScreenTouch:
		if area_input:
			if not event.pressed:
				pass
	
	area_input = false


func activate(): pass

func _on_area_2d_input_event(viewport, event, shape_idx):
	area_input = true
