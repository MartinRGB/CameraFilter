precision highp float;

uniform vec3                iResolution;
uniform sampler2D           iChannel0;
uniform float               iGlobalTime;
varying vec2                texCoord;


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{

	int choice = int( mod(iGlobalTime/3., 6.) );

	vec2 p = fragCoord.xy/iResolution.xy;

	// No Mirror
	// choice == 0

	// Left Mirror
	if(choice == 1){
		p.x -= step(0.5, p.x) * (p.x-0.5) * 2.0;
	}

	// Right Mirror
	if(choice == 2){
		p.x += step(p.x, 0.5) * (0.5-p.x) * 2.0;
	}

	// Top Mirror
	if(choice == 3){
		p.y -= step(p.y, 0.5) * (p.y-.5) * 2.0;
	}

	// Bottom Mirror
	if(choice == 4){
		p.y += step(0.5, p.y) * (0.5-p.y) * 2.0;
	}

	// Quad Mirror
	if(choice == 5){
		p.x += step(p.x, 0.5) * (0.5-p.x) * 2.0;
		p.y += step(0.5, p.y) * (0.5-p.y) * 2.0;
	}

	fragColor = texture2D(iChannel0, p);
}
void main() {
	mainImage(gl_FragColor, texCoord * iResolution.xy);
}