extends Node2D

export var begin_range : float = 0.0
var screen_size

var scale_scene
export var scale_distance : float = 500
export var scale_step : float = 300
export var scale_offset : float = 0.5
export var scale_balance : int = 2
export var add_lower_cloud : bool = false
export var add_higher_scale : bool = false

var cloud_scene
export var cloud_distance : float = 300

var plat_folder
var auto_move
var last_clound_pos = Vector2(0, 0)
var last_scale_pos = Vector2(0, 0)
var last_lower_clound_pos = Vector2(0, 0)
var last_higher_scale_pos = Vector2(0, 0)

func _ready() -> void:
	scale_scene = load("res://assets/scale/scale.tscn")
	cloud_scene = load("res://assets/cloud/cloud.tscn")
	plat_folder = get_parent()
	auto_move = get_parent().get_parent().get_node("AutoMove")
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	if begin_range < auto_move.position.x && !auto_move.get_parent().is_game_over:
		generate_cloud(delta)
		generate_scale(delta)
		if add_lower_cloud:
			generate_lower_cloud(delta)
		if add_higher_scale:
			generate_higher_scale(delta)

func generate_cloud(delta : float) ->void :
	if last_clound_pos.x + cloud_distance < auto_move.position.x + screen_size.x:
		var cloud_inst = cloud_scene.instance()
		plat_folder.add_child(cloud_inst)
		cloud_inst.position.x = auto_move.position.x + screen_size.x + 100 * (-0.5 + randf())
		cloud_inst.position.y = auto_move.position.y + (-0.5 + randf()) * screen_size.y 
		last_clound_pos = cloud_inst.position
		print("[CLOUD] spawn at ", last_clound_pos)

func generate_lower_cloud(delta : float) ->void :
	if last_lower_clound_pos.x + cloud_distance * 2 < auto_move.position.x + screen_size.x:
		var cloud_inst = cloud_scene.instance()
		plat_folder.add_child(cloud_inst)
		cloud_inst.position.x = auto_move.position.x + screen_size.x + 100 * (-0.5 + randf()) 
		cloud_inst.position.y = auto_move.position.y + (-0.2 + randf()) * screen_size.y 
		last_lower_clound_pos = cloud_inst.position
		print("[CLOUD] spawn at ", last_lower_clound_pos)

func generate_scale(delta : float) ->void :
	if last_scale_pos.x + scale_distance < auto_move.position.x + screen_size.x:
		var scale_inst = scale_scene.instance()
		scale_inst.position.x = auto_move.position.x + screen_size.x + 100 * (-0.5 + randf())
		scale_inst.position.y = last_scale_pos.y - (1 + scale_offset - randf()) * scale_step
		var base = int(randf() * 10)
		scale_inst.left_weight_number = base + (randf() - 0.5) * scale_balance
		scale_inst.right_weight_number = base + (randf() - 0.5) * scale_balance
		last_scale_pos = scale_inst.position
		plat_folder.add_child(scale_inst)
		print("[scale] spawn at ", last_scale_pos)
		
func generate_higher_scale(delta : float) ->void :
	if last_higher_scale_pos.x + scale_distance * 3 < auto_move.position.x + screen_size.x:
		var scale_inst = scale_scene.instance()
		scale_inst.position.x = auto_move.position.x + screen_size.x + 100 * (-0.5 + randf()) 
		scale_inst.position.y = last_higher_scale_pos.y - (1.5 + scale_offset - randf()) * scale_step 
		var base = int(randf() * 10)
		scale_inst.left_weight_number = base + (randf() - 0.5) * scale_balance
		scale_inst.right_weight_number = base + (randf() - 0.5) * scale_balance
		last_higher_scale_pos = scale_inst.position
		plat_folder.add_child(scale_inst)
		print("[scale] spawn at ", last_higher_scale_pos)
