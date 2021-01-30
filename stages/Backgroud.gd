extends Sprite

export var Velocity = Vector2(1.0, -1.0)

var g_texture_size: Vector2

func _ready():
	g_texture_size = texture.get_size() * scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	region_rect.position += Velocity
	
