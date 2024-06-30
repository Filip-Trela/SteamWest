extends Node2D

@onready var card_sel = get_parent().get_parent().get_node("CardSelected")
@onready var card_handler = get_parent().get_parent().get_node("CardHandler")

var area_input
var pressed
var dragging

var marker
var player


var card




func _input(event):
	if event is InputEventScreenTouch:
		if area_input:
			if not event.pressed:
				activate()
	
	area_input = false


func _on_area_2d_input_event(viewport, event, shape_idx):
	area_input = true



func activate():
	get_parent().hide_joys()
	card.null_card(player)
	
	card_sel.activate()
	card_handler.remove_high_card()
	
	
	
	
	
