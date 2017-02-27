precision highp float;

uniform vec3                iResolution;
uniform sampler2D           iChannel0;
varying vec2                texCoord;

// referenced the method of bitmap of iq : https://www.shadertoy.com/view/4dfXWj

vec2 texel_size = vec2(6.0,6.0);

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    fragCoord = floor(fragCoord/texel_size);	// Pixelify
    fragCoord /= iResolution.xy / texel_size;	// Correct scale

    float reaction_coordinate = texture2D(iChannel0, fragCoord).r;	// Use red channel

    float mixval = (((reaction_coordinate - 0.55) * 10.0 + 0.5) * 2.0);

    fragColor = vec4(mix(vec3(1.0, 0.58, 0.0),
                         vec3(1.0, 0.7, 0.4),
                         mixval),
                	 reaction_coordinate);

    fragColor.rgb = vec3(1.0, 0.2, 0.0);	// Red
    if (fragColor.a > 0.65) fragColor.rgb = vec3(1.0, 1.0, 1.0);	// White
    else if (fragColor.a > 0.37) fragColor.rgb = vec3(1.4, 0.8, 0.0);	// Yellow
    fragColor.a = float(fragColor.a > 0.1);
}


void main() {
	mainImage(gl_FragColor, texCoord * iResolution.xy);
}