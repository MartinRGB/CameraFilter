precision mediump float;

uniform vec3                iResolution;
uniform sampler2D           iChannel0;
varying vec2                 texCoord;



const float
	k1 = -1.0, k2 = -1.0, k3 = -1.0,
	k4 = -1.0, k5 = 8.0,  k6 = -1.0,
	k7 = -1.0, k8 = -1.0, k9 = -1.0;

float sigmoid(float a, float f)
{
	return 1.0/(1.0+exp(-f*a));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;

		uv = vec2(uv.x,uv.y);
		vec2 p = vec2(1.0,1.0) / iResolution.xy;
		vec4 colorSum =
			texture2D(iChannel0, uv + p * vec2(-1.0,-1.0)) * k1 +
			texture2D(iChannel0, uv + p * vec2( 0.0,-1.0)) * k2 +
			texture2D(iChannel0, uv + p * vec2( 1.0,-1.0)) * k3 +
			texture2D(iChannel0, uv + p * vec2(-1.0, 0.0)) * k4 +
			texture2D(iChannel0, uv + p * vec2( 0.0, 0.0)) * k5 +
			texture2D(iChannel0, uv + p * vec2( 1.0, 0.0)) * k6 +
			texture2D(iChannel0, uv + p * vec2(-1.0, 1.0)) * k7 +
			texture2D(iChannel0, uv + p * vec2( 0.0, 1.0)) * k8 +
			texture2D(iChannel0, uv + p * vec2( 1.0, 1.0)) * k9 ;

		vec3 c = colorSum.rgb;
		float avg = (c.r+c.g+c.b)/.5;
		float v = (1.0-sigmoid(avg-0.18, 9.0))*2.0;
		fragColor = vec4(v,v,v,1.0);
}


void main() {
	mainImage(gl_FragColor, texCoord * iResolution.xy);
}