extends Node2D

var player:CharacterBody2D
var combat_world:Node2D



@onready var rot_marker = preload("res://Scenes/Combat/Markers/rotate_marker.tscn")
@onready var move_marker = preload("res://Scenes/Combat/Markers/move_marker.tscn")
@onready var null_marker = preload("res://Scenes/Combat/Markers/null_marker.tscn")

var marker



func _ready():
	hide_joys()
	player = get_parent().get_parent().get_node("CombatWorld/PlayerGroup/Player")
	combat_world = get_parent().get_parent().get_node("CombatWorld")
	
	


func _process(delta):
	pass


func start(type):
	for child in combat_world.get_node("Markers").get_children():
		child.queue_free()
	
	match type:
		"rotate": 
			$RotateJoy.visible = true
			$RotateJoy["process_mode"] = Node.PROCESS_MODE_INHERIT
			
			
			marker = rot_marker.instantiate()
			marker.global_position = player.global_position
			$RotateJoy.marker = marker
			marker.scale = Vector2(1,0)
			
			combat_world.get_node("Markers").add_child(marker)
			marker = null
			
		"move": 
			$MoveJoy.visible = true
			$MoveJoy["process_mode"] = Node.PROCESS_MODE_INHERIT
			
			marker = move_marker.instantiate()
			marker.global_position = player.global_position
			$MoveJoy.marker = marker
			
			combat_world.get_node("Markers").add_child(marker)
			marker = null
			
		"null":
			$NullJoy.visible = true
			$NullJoy["process_mode"] = Node.PROCESS_MODE_INHERIT
			
			marker = null_marker.instantiate()
			marker.global_position = player.global_position
			$NullJoy.marker = marker
			
			combat_world.get_node("Markers").add_child(marker)
			marker = null


func hide_joys():
	for child in get_children():
		child.visible = false
		child["process_mode"] = Node.PROCESS_MODE_DISABLED
