extends Node2D


@onready var handler = get_parent().get_node("CardHandler")

@onready var card_pl = preload("res://Scenes/Combat/Gui/Card/card.tscn")
var card

var choosen_card

var area_input = false
var pressed= false
var dragging = false

var has_card = false




func _input(event):
	if event is InputEventScreenTouch:
		if area_input:
			if event.pressed and not dragging and not pressed:
				$Timer.start(0.1)
				pressed = true
				
				
			elif not event.pressed:
				if dragging == false:
					activate()
				pressed = false
				dragging = false
				$Timer.stop()
		
	area_input = false


func card_selected(high_card):
	has_card = true
	choosen_card = high_card
	card = card_pl.instantiate()
	
	card.text_set = high_card.text_set
	card.scale = Vector2(0.3, 0.3)
	
	$CardPosition.add_child(card)



func activate():
	if has_card:
		var marker_group = get_parent().get_parent().get_node("CombatWorld/Markers")
		for marker in marker_group.get_children():
			marker.queue_free()
		
		
		handler.visible = true
		handler["process_mode"] = Node.PROCESS_MODE_INHERIT
		$CardPosition.get_child(0).queue_free()
		
		has_card = false
		choosen_card = null
		has_card = false
		
		get_parent().get_node("DiffInputHandler").hide_joys()



func _on_area_2d_input_event(viewport, event, shape_idx):
	area_input = true


func _on_timer_timeout():
	dragging = true
