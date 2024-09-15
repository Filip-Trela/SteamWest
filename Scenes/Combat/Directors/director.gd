extends Node


var card_handler
var card_selector
var deck
var timer

#states: input, action, next turn, next battle,



# Called when the node enters the scene tree for the first time.
func _ready():
	card_handler = get_parent().get_node("CombatGui/CardHandler")
	card_selector = get_parent().get_node("CombatGui/CardSelected")
	deck = get_parent().get_node("Deck")
	timer = get_parent().get_node("CombatGui/Timer")



func during_action():
	card_handler["process_mode"] = Node.PROCESS_MODE_DISABLED
	card_selector["process_mode"] = Node.PROCESS_MODE_DISABLED

func next_turn():
	card_handler["process_mode"] = Node.PROCESS_MODE_INHERIT
	card_selector["process_mode"] = Node.PROCESS_MODE_INHERIT
	deck.next_turn()
	card_handler.next_turn()
