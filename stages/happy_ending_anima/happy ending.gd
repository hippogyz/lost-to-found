extends Node2D

export var pre_time_max : float = 3.0
export var first_walk_time : float = 6.0
var first_played = false
export var second_walk_time : float = 5.0
var second_played = false
var current_time
onready var pre_curtain = get_node("ColorRect")
var pre_anima_playing

func _ready():
	MusicPlayer.play("res://sound/up-on-a-housetop-by-kevin-macleod-from-filmmusic-io (1).ogg")
	pre_curtain.color.a = 1
	current_time = 0.0
	pre_anima_playing = true
	
	first_walk_time = pre_time_max + first_walk_time
	second_walk_time = first_walk_time + second_walk_time

func _process(delta: float) -> void:
	_play_animation(current_time)
	current_time += delta

func _play_animation(time : float) -> void:
	if time < pre_time_max:
		pass
	elif time > first_walk_time && !first_played:
		$staff/AnimationPlayer.play("appear")
		$character_he.play_anima("hum")
		first_played = true
	elif time > second_walk_time && !second_played:
		
		$character_he._anima_friend()
		second_played = true
	

func _set_background_move(is_stop : bool) -> void:
	var bg_list = $ParallaxBackground/ParallaxLayer.get_children()
	for bg in bg_list:
		bg.is_stop = is_stop
	var bg_list2 = $ParallaxBackground2.get_children()
	for bg in bg_list2:
		bg.is_stop = is_stop
	
