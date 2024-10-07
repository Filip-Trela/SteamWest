extends Enemy


func  behaviour():
	match range_to_p:
		"close":
			if nav_target == get_tree().get_first_node_in_group("Player"):
				state_beh = "finding escape route"
			else:
				state_beh = "running away from player"
		"mid_close":
			if nav_target == get_tree().get_first_node_in_group("Player"):
				state_beh = "finding escape route"
			else:
				state_beh = "running away from player"
		"mid":
			if not ray_col and last_acts[1] != "shooting":
				state_beh = "shooting"
			elif not ray_col:
				state_beh = "following player"
			else:
				state_beh = "going sideways"
		"mid_far":
			if not ray_col and last_acts[1] != "shooting":
				state_beh = "shooting"
			
			else:
				state_beh = "following player"
		"far":
			state_beh = "following player"
			
	if len(danger_arr) != 0:
		state_beh = "danger"
