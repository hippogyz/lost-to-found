extends Node2D

export var pre_time_max : float = 3.0
var pre_time
onready var pre_curtain = get_node("ColorRect")
var pre_anima_playing

func _ready():
	pre_curtain.color.a = 1
	pre_time = pre_time_max
	pre_anima_playing = true

func _process(delta: float) -> void:
	if pre_anima_playing:
		if pre_time > 0:
			pre_time -= delta
			pre_curtain.color.a = max( 0.0, pre_curtain.color.a - 1.0 / pre_time_max * delta)
		else:
			pre_anima_playing = false
			get_node("character_he").controlable = true
