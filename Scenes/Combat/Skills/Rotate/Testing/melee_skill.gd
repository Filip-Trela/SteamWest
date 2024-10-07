extends Node2D

var speed
var toss
var damage
var env_destroy_index

var timer

var mov_vec

var entity


var danger_type = "moving" #static(like move, area circle) moving (like bullets)

func _ready() -> void:
	$AnimationPlayer.play("start")
	timer = get_tree().get_nodes_in_group("Timer")[0]

	$RotatePart.rotation = mov_vec.angle()

func _process(delta: float) -> void:
	self.global_position = entity.global_position


#for hurtboxes
func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	var enemy = area.get_parent()
	var toss_dir = enemy.global_position - self.global_position
	toss_dir = toss_dir.normalized()
	
	enemy.take_damage(damage, toss_dir, toss)


func interactable_enviroment_hit():
	env_destroy_index -= 1

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
		queue_free()
