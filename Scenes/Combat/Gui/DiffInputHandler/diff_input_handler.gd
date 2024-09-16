extends Node2D

var player:CharacterBody2D
var combat_world:Node2D
var card_selector:Node2D



@onready var rot_marker = preload("res://Scenes/Combat/Markers/rotate_marker.tscn")
@onready var move_marker = preload("res://Scenes/Combat/Markers/move_marker.tscn")
@onready var null_marker = preload("res://Scenes/Combat/Markers/null_marker.tscn")

var marker



func _ready():
	custom_ready()

func custom_ready():
	hide_joys()
	player = get_tree().get_first_node_in_group("Player")
	combat_world = get_parent().get_parent().get_node("CombatWorld/NavigationRegion2D/Y_sort")
	card_selector = get_parent().get_parent().get_node("CombatGui/CardSelected")
	
	for child in get_children():
		child.custom_ready()
	
	$RotateJoy.player = player
	$MoveJoy.player = player
	$NullJoy.player = player



func start(text_set):
	for marker in get_tree().get_nodes_in_group("Markers"):
		marker.queue_free()
	
	var type = text_set[2]


	match type:
		"rotate": 
			$RotateJoy.text_set = text_set
			$RotateJoy.visible = true
			$RotateJoy["process_mode"] = Node.PROCESS_MODE_INHERIT
			
			$RotateJoy.card = card_selector.get_node("CardPosition").get_child(0)
			
			marker = rot_marker.instantiate()
			marker.global_position = player.global_position
			marker.scale = Vector2(1,0)
			$RotateJoy.marker = marker
			
			
			combat_world.add_child(marker)
			marker = null
			
		"move": 
			$MoveJoy.text_set = text_set
			$MoveJoy.visible = true
			$MoveJoy["process_mode"] = Node.PROCESS_MODE_INHERIT
			
			$MoveJoy.card = card_selector.get_node("CardPosition").get_child(0)
			$MoveJoy.range = int(text_set[15])
			
			marker = move_marker.instantiate()
			marker.global_position = player.global_position
			$MoveJoy.marker = marker
			
			combat_world.add_child(marker)
			marker = null
			
		"null":
			$NullJoy.text_set = text_set
			$NullJoy.visible = true
			$NullJoy["process_mode"] = Node.PROCESS_MODE_INHERIT
			
			$NullJoy.card = card_selector.get_node("CardPosition").get_child(0)
			
			marker = null_marker.instantiate()
			marker.global_position = player.global_position
			$NullJoy.marker = marker
			
			combat_world.add_child(marker)
			marker = null


func hide_joys():
	for child in get_children():
		child.visible = false
		child["process_mode"] = Node.PROCESS_MODE_DISABLED
