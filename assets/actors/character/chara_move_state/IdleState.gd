extends "chara_move_state.gd"

func enter_state() :
	play_animation("idle_anima")

func exit_state() : 
	pass

func update(delta:float):
	var input_dir = get_input_direction()
	if !on_ground():
		emit_signal("state_exit_signal", "jump")
		return
	if input_dir != Vector2.ZERO:
		emit_signal("state_exit_signal", "move")
		return

func handle_input() :
	if Input.is_action_just_pressed("jump_order"):
		jump()
		emit_signal("state_exit_signal", "jump")
		return
	.handle_input()
