extends Node2D

export var begin_range : float = 0.0
var screen_size

var scale_scene
var scale_protect_time
export var scale_freq : float = 4.0
export var scale_prob : float = 0.2

var cloud_scene
var cloud_protect_time
export var cloud_freq : float = 3.0
export var cloud_prob : float = 0.4

var plat_folder
var auto_move

func _ready() -> void:
	scale_scene = load("res://assets/scale/scale.tscn")
	scale_protect_time = scale_freq
	cloud_scene = load("res://assets/cloud/cloud.tscn")
	cloud_protect_time = cloud_freq
	plat_folder = get_parent()
	auto_move = get_parent().get_parent().get_node("AutoMove")
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	if begin_range < auto_move.position.x && !auto_move.get_parent().is_game_over:
		generate_cloud(delta)
		generate_scale(delta)

func generate_cloud(delta : float) ->void :
	if cloud_protect_time < 0 && randf() < cloud_prob:
		for i in range(1):
			var cloud_inst = cloud_scene.instance()
			plat_folder.add_child(cloud_inst)
			cloud_inst.position.x = auto_move.position.x + screen_size.x * (0.9 + 0.3 * (i + randf())) 
			cloud_inst.position.y = auto_move.position.y + (0.3 + randf()) * screen_size.y * (1 - 0.5 * i)
		
		cloud_protect_time = cloud_freq
	else:
		cloud_protect_time -= delta

func generate_scale(delta : float) ->void :
	if scale_protect_time < 0 && randf() < scale_prob:
		for i in range(1):
			var scale_inst = scale_scene.instance()
			plat_folder.add_child(scale_inst)
			scale_inst.position.x = auto_move.position.x + screen_size.x * (1.0 + 0.2 * randf())
			scale_inst.position.y = auto_move.position.y + (1.0 + randf()) * screen_size.y * (0.2 - 0.7*i)
			scale_inst.left_weight_number = 5 + 3 * int(randf())
			scale_inst.right_weight_number = 5 + 3 * int(randf())
		
		scale_protect_time = scale_freq
	else:
		scale_protect_time -= delta
