extends Node2D


var text_set

var entity

@onready var combat_world = get_tree().get_first_node_in_group("Y_Sort_World")

var deck



#for director
var activated = false

var timer

var player_nodes


func _ready():
	timer = get_tree().get_nodes_in_group("Timer")[0]
	#combat_world = get_tree().get_first_node_in_group("Y_Sort_World")
	
	
	if text_set:
		$Title.text = text_set[0]
		$Description.text = text_set[1]
	
	player_nodes = get_tree().get_nodes_in_group("Player")





func rotate_card(entity_load, direction, len_strength):
	entity = entity_load
	if text_set[11] != "None":
		var eff = load(text_set[11]).instantiate()
		eff.global_position = entity.global_position
		var dir = Vector2(direction.x, direction.y)
		dir = dir.rotated(deg_to_rad(int(text_set[12])))
		eff.set_gravity(Vector2(dir.x, dir.y))
		
		if text_set[13] == "true":
			eff.keep_target = entity
		combat_world.add_child(eff)
	
	
	if text_set[17] == "true":
		entity.dir_current = Vector2(0,0)
		entity.speed = 0
		
	if text_set[18] == "true":
		entity.set_custom_deceleration(int(text_set[18]))
		
	if int(text_set[3]) > 0:
		entity.dir = direction
		entity.speed += len_strength * int(text_set[3])
	elif int(text_set[3]) < 0:
		entity.dir = Vector2(-direction.x, -direction.y)
		entity.speed += len_strength * abs(int(text_set[3]))
	
	if text_set[4] != "null":
		var skill = load(text_set[4])
		
		for single in range(int(text_set[6])):
			var skill_instance = skill.instantiate()
			skill_instance.global_position = entity.global_position
			if single%2:
				skill_instance.mov_vec = direction.rotated(-deg_to_rad(int(text_set[7]))\
				 * (single%2 + single)/2)
			else:
				skill_instance.mov_vec = direction.rotated(deg_to_rad(int(text_set[7]))\
				 *(single%2 + single)/2)
			
			skill_instance.speed = int(text_set[5])
			set_area_collision(skill_instance)
			skill_instance.toss = int(text_set[8])
			skill_instance.damage = int(text_set[9])
			skill_instance.env_destroy_index = int(text_set[14])
			
			skill_instance.entity = entity
			
			combat_world.add_child(skill_instance)
			
	entity.action_timer_start(float(text_set[10]))


#TODO change after doing rotate
func move_card(entity_load, marker):
	entity = entity_load
	
	
	var skill = load(text_set[4])
	var skill_instance = skill.instantiate()
	skill_instance.global_position = marker.global_position
	skill_instance.damage = int(text_set[9])
	set_area_collision(skill_instance)
	combat_world.add_child(skill_instance)
	
	
	entity.action_timer_start(float(text_set[10]))

#TODO change after doing rotate
func null_card(entity_load):
	entity = entity_load
	
	
	var skill = load(text_set[4])
	var skill_instance = skill.instantiate()
	skill_instance.global_position = entity.global_position
	skill_instance.damage = int(text_set[9])
	set_area_collision(skill_instance)
	combat_world.add_child(skill_instance)
	
	entity.action_timer_start(float(text_set[10]))




func set_area_collision(inst_skill):
	if entity in player_nodes:
		inst_skill.get_node("RotatePart/Area2D").collision_mask = 10 #enemy and world
	else:
		inst_skill.get_node("RotatePart/Area2D").collision_mask = 6 #player and world
