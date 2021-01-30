shader_type canvas_item;

uniform float blackness;

void fragment(){
	vec4 col = texture(TEXTURE, UV);
	col.rbg *= (1.0 - blackness);
	
	COLOR = col;
}