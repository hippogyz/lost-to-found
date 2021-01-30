extends KinematicBody2D


export var velocity_value : float = 200.0
export var _gravity :float = 1500.0

var _velocity : Vector2
var _height : float
var _height_velocity : float
var _max_height_velocity : float = 800.0

var look_direction : Vector2

func _ready() -> void:
	_velocity = Vector2.ZERO
	_height = 0
	_height_velocity = 0

func _physics_process(delta: float) -> void:
	_velocity = move_and_slide(_velocity * delta)
	
	if !on_ground():
		$sprite.position.y = -_height
		_height = max(0, _height + _height_velocity * delta)
		_height_velocity = max(- _max_height_velocity, _height_velocity - _gravity * delta)

func on_ground() -> bool:
	return _height < 0.1 && _height_velocity <= 0

func set_velocity(delta : float, dir : Vector2) :
	_velocity = dir * velocity_value

func do_jump():
	_height_velocity = _max_height_velocity
