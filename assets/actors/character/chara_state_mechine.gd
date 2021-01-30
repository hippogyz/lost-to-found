extends "res://assets/actors/state_mechine/state_mechine.gd"

func _ready() : 
	state_map = { 
		"idle": $IdleState,
		"move": $MoveState,
		"jump": $JumpState
		 }

func _change_state(next_state_name) :
	if not _active:
		return
	._change_state(next_state_name)

