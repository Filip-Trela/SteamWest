extends Node2D

var player

@onready var top = get_parent().get_node("TopCorner") # 400
@onready var bottom = get_parent().get_node("BottomCorner") #500

var y_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("Player")
	global_position.x = get_viewport_rect().size.x/2
	global_position.y = player.global_position.y
	



func _process(delta):
	var player_offset = player.global_position.y
	var speed =  abs(player.global_position.y - global_position.y) * 0.01
	
	
	y_pos = move_toward(global_position.y, player.global_position.y, speed)
	y_pos = clamp(y_pos, top.global_position.y, bottom.global_position.y)
	global_position.y = y_pos
