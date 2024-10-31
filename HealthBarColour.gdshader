shader_type canvas_item;
uniform vec4 barColour : source_color;
uniform vec4 barColourShade : source_color;
uniform vec4 rimColour : source_color;
uniform float flashing : hint_range(0.0, 1.0);

void fragment() {
	vec4 pixelColour = COLOR;
	float value = (pixelColour.r + pixelColour.g + pixelColour.b) / 3.0;
	if(value >= 0.9){
		pixelColour.rgb = mix(barColour, barColourShade, pow(UV.y, 1.8)).rgb;
	}
	else if(value < 0.4){
		pixelColour.rgb *= pow(sin(UV.y * 2.0 + 0.5), 4);
	}
	else{
		pixelColour.rgb = rimColour.rgb;
	}
	COLOR = pixelColour;
}
