precision highp float;

uniform vec3                iResolution;
uniform float               iGlobalTime;
uniform sampler2D           iChannel0;
varying vec2                texCoord;

void mainImage(out vec4 o,vec2 u)
{
    u = u / iResolution.x - .8;
    o = texture2D( iChannel0, fract( .2*iGlobalTime - vec2(u.x,1)/u.y ) )* -u.y*3.;
}

void main() {
	mainImage(gl_FragColor, texCoord * iResolution.xy);
}