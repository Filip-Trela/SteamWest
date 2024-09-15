extends Node2D

var card_sel
var card_handler
var comb_world
var deck

var area_input

var pressed
var dragging

var marker
var player


var card

func _ready() -> void:
	custom_ready()

func custom_ready():
	card_sel = get_parent().get_parent().get_node("CardSelected")
	card_handler = get_parent().get_parent().get_node("CardHandler")
	comb_world = get_parent().get_parent().get_parent().get_node("CombatWorld/NavigationRegion2D/Y_sort")
	deck = get_parent().get_parent().get_parent().get_node("Deck")

func activate():
	get_parent().hide_joys()
	card.deck = deck
	card.null_card(player, comb_world)
	
	
	card_sel.activate()
	card_handler.remove_high_card()
	
	
	
	
	


func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if not event.pressed:
			activate()
