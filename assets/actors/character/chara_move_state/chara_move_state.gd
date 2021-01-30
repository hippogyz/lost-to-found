extends "res://assets/actors/state_mechine/state/state.gd"

func enter_state() :
	pass

func exit_state() : 
	pass

func update(delta:float):
	pass

func handle_input() :
	.handle_input()

func get_input_direction() -> Vector2 : 
	var input_dir : Vector2
	input_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_dir.y = 0.0
	#input_dir.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_dir = input_dir.normalized()
	
	return input_dir

func move(delta : float, dir : Vector2) :
	var velocity = owner.velocity_value * dir
	owner.set_velocity(delta, dir)

func jump():
	owner.do_jump()

func on_ground() -> bool :
	return owner.on_ground()

func play_animation(anima_name : String) :
	owner.get_node("AnimationTree").get("parameters/playback").travel(anima_name)
	#owner.get_node("AnimationPlayer").play(anima_name)
