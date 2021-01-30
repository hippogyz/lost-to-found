extends RigidBody2D

onready var ground_detector = get_node("GroundDetector")

export var velocity_value : float = 200.0
export var _jump_velocity : float = 200.0

var _velocity : Vector2
var is_jump : bool = false
var jump_protect_time = 0.1
var _max_height_velocity : float = 800.0

var look_direction : Vector2

func _ready() -> void:
	_velocity = Vector2.ZERO


func _integrate_forces(s) ->void :
	var lv = s.get_linear_velocity()
	
	lv.x = _velocity.x
	
	if jump_protect_time > 0:
		jump_protect_time -= s.step
	if is_jump:
		is_jump = false
		lv.y -= _jump_velocity
	lv.y = min(lv.y, _max_height_velocity)
	
	if lv.y < 0.0:
		if !on_ground():
			switch_collision(false)
	else:
		switch_collision(true)
	
	s.set_linear_velocity(lv)
	s.set_angular_velocity(- rotation_degrees * 0.5 )


func on_ground() -> bool:
	for rc in ground_detector.get_children():
		if rc.is_colliding(): 
			return true
	return false

func set_velocity(delta : float, dir : Vector2) :
	_velocity = dir * velocity_value

func do_jump():
	if jump_protect_time <=0:
		is_jump = true
		jump_protect_time = 0.1
	
func switch_collision(enable : bool) -> void:
	if enable:
		collision_layer = 1
		collision_mask = 4
	else:
		collision_layer = 256
		collision_mask = 256
	
