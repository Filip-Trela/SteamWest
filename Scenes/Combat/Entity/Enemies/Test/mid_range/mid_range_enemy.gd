extends Enemy






func  behaviour():
	if range_to_p == "far":
		state_beh = "following player"
		
	elif range_to_p == "mid":
		if not ray_col and last_acts[1] != "shooting":
			state_beh = "shooting"
		
		else:
			state_beh = "following player"
	
	else: #close
		pass
	
	if len(danger_arr) != 0:
		state_beh = "danger"
