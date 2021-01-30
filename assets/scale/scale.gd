extends Node2D

export var arm_scale : float = 1.0
export var left_weight_number : int = 0
export var right_weight_number : int = 0
onready var weight_group = get_node("weight_group")
var weight_scene

func _ready() -> void:	
	weight_scene = load("res://assets/weight_cubic/weight.tscn")
	
	var colu = round(sqrt(left_weight_number))
	for i in range(left_weight_number):
		var weight_inst = weight_scene.instance()
		weight_group.add_child(weight_inst)
		
		var c = floor(i/colu) - left_weight_number/colu/2.0
		var l = i - floor(i/colu)*colu - colu/2
		var cub_size = weight_inst.get_node("CollisionShape2D").shape.extents
		weight_inst.position = Vector2(-190.0, 130.0) + Vector2(c,l) * cub_size * Vector2(1.0, -1.0)
		
	colu = round(sqrt(right_weight_number))
	for i in range(right_weight_number):
		var weight_inst = weight_scene.instance()
		weight_group.add_child(weight_inst)
		
		var c = floor(i/colu) - right_weight_number/colu/2.0
		var l = i - floor(i/colu)*colu - colu/2
		var cub_size = weight_inst.get_node("CollisionShape2D").shape.extents
		weight_inst.position = Vector2(190.0, 130.0) + Vector2(c,l) * cub_size * Vector2(-1.0, -1.0)
	
	get_node("arm").scale.x = arm_scale




