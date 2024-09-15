extends CharacterBody2D



var toss
var damage
var env_destroy = false

var timer

var destroy_at_end = true



func _ready() -> void:
	timer = get_tree().get_nodes_in_group("Timer")[0]
	$AnimationPlayer.play("start")


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var enemy = area.get_parent()
	enemy.take_damage(damage)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
