extends Node

var combat
var combat_gui
@onready var stager_pl = preload("res://Scenes/Combat/Gui/BetweenStager/between_stager.tscn")

var stage_ended = false

@onready var combat_stage_pl = preload("res://Scenes/Combat/World/combat_world.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	combat = get_parent().get_parent()
	combat_gui = combat.get_node("CombatGui")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not len(get_tree().get_nodes_in_group("Enemy")) and not stage_ended:
		stage_end()

func stage_end():
	stage_ended = true
	combat_gui["visible"] = false
	combat_gui["process_mode"] = Node.PROCESS_MODE_DISABLED
	var stager = stager_pl.instantiate()
	combat.add_child(stager)
	
	get_tree().get_first_node_in_group("CombatWorld").queue_free()

func next_stage():
	combat.get_node("BetweenStager").queue_free()
	combat_gui["visible"] = true
	combat_gui["process_mode"] = Node.PROCESS_MODE_INHERIT
	
	var combat_stage = combat_stage_pl.instantiate()
	combat.add_child(combat_stage)
	
	combat.get_node("Deck").start()
	combat_gui.get_node("DiffInputHandler").custom_ready()
	combat_gui.get_node("CardHandler").next_turn()
	get_tree().get_first_node_in_group("Timer").custom_ready()
	stage_ended = false
