precision highp float;

uniform vec3                iResolution;
uniform sampler2D           iChannel0;
varying vec2                texCoord;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 xy = fragCoord.xy / iResolution.xy;
    //xy.y = 1.0 - xy.y; // invert
    //xy.x = 1.0 - xy.x; // flip
    vec4 texColor = texture2D(iChannel0,xy);
    float avg = (texColor.r + texColor.g + texColor.b) / 3.0; // grayscale
	texColor.r *= abs(cos(avg));
    texColor.g *= abs(sin(avg));
    texColor.b *= abs(atan(avg) * sin(avg));
    fragColor = texColor;
}

void main() {
	mainImage(gl_FragColor, texCoord*iResolution.xy);
}