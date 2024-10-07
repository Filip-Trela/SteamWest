extends CPUParticles2D

var keep_target

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	one_shot = true
	emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if keep_target in get_tree().get_nodes_in_group("Entity"):
		global_position = keep_target.global_position


func _on_finished() -> void:
	self.queue_free()
