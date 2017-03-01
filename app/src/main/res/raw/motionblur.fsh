precision highp float;

uniform vec3                iResolution;
uniform float               iGlobalTime;
uniform sampler2D           iChannel0;
varying vec2                texCoord;

const float size = 3.0;
const float interleave = 2.0;
const float framerate = 60.0;
const float size2 = size*size;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 smallGrid = floor(mod(fragCoord, size));
    float pixelIndex = smallGrid.y * size + smallGrid.x;
    float frame = floor(iGlobalTime * framerate);
    if (pixelIndex != mod(frame*interleave, size2))
        discard;

	fragColor = texture2D(iChannel0, fragCoord / iResolution.xy);
}

void main() {
	mainImage(gl_FragColor, texCoord * iResolution.xy);
}