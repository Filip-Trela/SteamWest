extends Entity

class_name Enemy

@onready var entity_label_pl = preload("res://Scenes/Combat/Gui/EntityLabel/entity_label.tscn")

@onready var combat_gui = get_parent().get_parent().get_parent().get_node("CombatGui")

var timer_label = 0.8
var label_name = "Enemy numbero uno forevero"

var player:CharacterBody2D

@onready var navi_ag:NavigationAgent2D = $NavigationAgent2D


#for behaviour
var range_to_p = "far" #close, mid, far

@onready var timer_b = $TimerActions
var state_beh = "waiting"#behaviour state
#waiting, in danger, following



var can_act = false

var path
var angle_tolerance = 10

@onready var card_pl = preload("res://Scenes/Combat/Gui/Card/card.tscn")
var card



var lower_for_calc = 55.55556


func custom_ready():
	card = card_pl.instantiate()
	$Invisible.add_child(card)
	$HurtBox["collision_layer"] = 8
	player = get_tree().get_first_node_in_group("Player")
	navi_ag.target_position = player.global_position
	
	timer_b.start(randf_range(0.2, 0.4))
	set_cards()
	
	navi_ag.path_desired_distance = 4.0
	navi_ag.target_desired_distance = 4.0
	

func set_cards():
	pass

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
	
	path = navi_ag.get_current_navigation_path()
	
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


func behaviour():
	pass


func _on_timer_actions_timeout() -> void:
	can_act = true


func action_timer_start(recovery_time):
	can_act = false
	$TimerActions.start(recovery_time)
