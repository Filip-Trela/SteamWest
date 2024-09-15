extends Node2D


@onready var handler = get_parent().get_node("CardHandler")

@onready var card_pl = preload("res://Scenes/Combat/Gui/Card/card.tscn")
var card

var choosen_card

var pressed= false
var dragging = false

var has_card = false





func card_selected(high_card):
	has_card = true
	choosen_card = high_card
	card = card_pl.instantiate()
	
	card.text_set = high_card.text_set
	card.scale = Vector2(0.3, 0.3)
	
	$CardPosition.add_child(card)



func activate():
	if has_card:
		for marker in get_tree().get_nodes_in_group("Markers"):
			marker.queue_free()
		
		
		handler.visible = true
		handler["process_mode"] = Node.PROCESS_MODE_INHERIT
		$CardPosition.get_child(0).queue_free()
		
		has_card = false
		choosen_card = null
		has_card = false
		
		get_parent().get_node("DiffInputHandler").hide_joys()



func _on_timer_timeout():
	dragging = true


func _on_touch_area_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed and not dragging and not pressed:
			$Timer.start(Settings.drag_timer)
			pressed = true
			
			
		elif not event.pressed:
			if dragging == false:
				activate()
			pressed = false
			dragging = false
			$Timer.stop()
