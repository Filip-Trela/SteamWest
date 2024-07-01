extends Node


@onready var card_handler = get_parent().get_parent().get_node("CombatGui/CardHandler")
@onready var card_selector = get_parent().get_parent().get_node("CombatGui/CardSelected")
@onready var deck = get_parent().get_parent().get_node("Deck")

#states: input, action, next turn, next battle,

var all_states = [
	"input",
	"action",
	"next turn"
] 

var state = "input"

#changes in card scene
var during_action = false



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		"input":
			if during_action == true:
				#change later
				card_handler["process_mode"] = Node.PROCESS_MODE_DISABLED
				card_selector["process_mode"] = Node.PROCESS_MODE_DISABLED
				state = "action"
				
		"action":
			#sprawdza wszystkie entity i skille czy minely
			var entity_moving = false
			var skill_is = false
			
			for entity in get_tree().get_nodes_in_group("Entity"):
				if entity.mov_vec != Vector2(0,0):
					entity_moving = true
			
			for skill in get_tree().get_nodes_in_group("Skill"):
				skill_is = true
			
			
			#probably should be come back to input and normal click for next turn
			if not entity_moving and not skill_is:
				during_action = false
				state = "next turn"

		"next turn":
			card_handler["process_mode"] = Node.PROCESS_MODE_INHERIT
			card_selector["process_mode"] = Node.PROCESS_MODE_INHERIT
			deck.next_turn()
			card_handler.next_turn()
			state = "input"
