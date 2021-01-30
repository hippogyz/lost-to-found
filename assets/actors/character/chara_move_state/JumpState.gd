extends "chara_move_state.gd"

func enter_state() :
	play_animation("jump_anima")

func exit_state() : 
	pass

func update(delta:float):
	var input_dir = get_input_direction()
	move(delta, input_dir)
	if on_ground():
		if input_dir == Vector2.ZERO :
			emit_signal("state_exit_signal", "idle")
		else:
			emit_signal("state_exit_signal", "move")
		return

func handle_input() :
	.handle_input()

