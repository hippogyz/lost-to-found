extends Sprite

export var Velocity = Vector2(1.0, -1.0)
export var is_stop = false
var g_texture_size: Vector2

func _ready():
	g_texture_size = texture.get_size() 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_stop:
		pass
	else:
		region_rect.position += Velocity
	
