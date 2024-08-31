extends Node


@onready var card_handler = get_parent().get_parent().get_node("CombatGui/CardHandler")
@onready var card_selector = get_parent().get_parent().get_node("CombatGui/CardSelected")
@onready var deck = get_parent().get_parent().get_node("Deck")
@onready var turn_i = get_parent().get_parent().get_node("CombatGui/TurnIndicator")
@onready var timer = get_parent().get_parent().get_node("CombatGui/Timer")

#states: input, action, next turn, next battle,



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func during_action():
	card_handler["process_mode"] = Node.PROCESS_MODE_DISABLED
	card_selector["process_mode"] = Node.PROCESS_MODE_DISABLED

func next_turn():
	card_handler["process_mode"] = Node.PROCESS_MODE_INHERIT
	card_selector["process_mode"] = Node.PROCESS_MODE_INHERIT
	deck.next_turn()
	card_handler.next_turn()
	turn_i.next_turn()
