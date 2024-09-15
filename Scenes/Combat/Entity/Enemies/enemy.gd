extends Entity

class_name Enemy

@onready var entity_label_pl = preload("res://Scenes/Combat/Gui/EntityLabel/entity_label.tscn")

@onready var combat_gui = get_parent().get_parent().get_parent().get_node("CombatGui")

var timer_label = 0.8
var label_name = "Enemy numbero uno forevero"

var player:CharacterBody2D

@onready var navi_ag = $NavigationAgent2D


#for behaviour
var range_to_p = "far" #close, mid, far

@onready var timer_b = $Timer
var state_beh = "waiting"#behaviour state
#waiting, in danger, following


func custom_ready():
	$HurtBox["collision_layer"] = 8
	player = get_tree().get_first_node_in_group("Player")
	navi_ag.target_position = player.global_position
	
	timer_b.start(randf_range(0.2, 0.4))
	



func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			$TimerLabel.start(timer_label)
		else:
			$TimerLabel.stop()


func _on_timer_label_timeout() -> void:
	var entity_label = entity_label_pl.instantiate()
	entity_label.entity_name = label_name
	
	combat_gui.add_child(entity_label)




#BEHAVIOUR AND NAVIGATING
func custom_process():
	if timer.paused:
		timer_b.paused = true
	else:
		timer_b.paused = false
	
	#print(player.velocity)
	
	navi_ag.target_position = player.global_position
	
	$RayCast2D.target_position = player.global_position - self.global_position
	
	var distance_to_player = self.global_position.distance_to(player.global_position)
	if distance_to_player < 180:
		range_to_p = "close"
	elif distance_to_player < 400:
		range_to_p = "mid"
	else:
		range_to_p = "far"
	
	behaviour()
	print(global_position.distance_to(player.global_position))


func behaviour():
	pass


func _on_timer_timeout() -> void:
	if state_beh == "waiting":
		state_beh = "following"
