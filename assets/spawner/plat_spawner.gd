extends Node2D

export var begin_range : float = 2000.0
var screen_size

var scale_scene
var scale_protect_time
export var scale_freq : float = 2.0
export var scale_prob : float = 0.5

var cloud_scene
var cloud_protect_time
export var cloud_freq : float = 2.0
export var cloud_prob : float = 0.5

var plat_folder

func _ready() -> void:
	scale_scene = load("res://assets/scale/scale.tscn")
	scale_protect_time = scale_freq
	cloud_scene = load("res://assets/cloud/cloud.tscn")
	cloud_protect_time = cloud_freq
	plat_folder = get_parent().get_parent().get_node("PlatContainer")
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	if begin_range > get_parent().position.x:
		generate_cloud(delta)
		generate_scale(delta)

func generate_cloud(delta : float) ->void :
	if cloud_protect_time < 0 && randf() < cloud_prob:
		var cloud_inst = cloud_scene.instance()
		plat_folder.add_child(cloud_inst)
		cloud_inst.position.x = screen_size.x 
		cloud_inst.position.y = (randf() - 0.5) * screen_size.y
		
		cloud_protect_time = cloud_freq
	else:
		cloud_protect_time -= delta

func generate_scale(delta : float) ->void :
	if scale_protect_time < 0 && randf() < scale_prob:
		var scale_inst = scale_scene.instance()
		plat_folder.add_child(scale_inst)
		scale_inst.position.x = screen_size.x 
		scale_inst.position.y = (randf() - 0.5) * screen_size.y
		
		scale_protect_time = scale_freq
	else:
		scale_protect_time -= delta
