precision highp float;

uniform vec3                iResolution;
uniform float               iGlobalTime;
uniform sampler2D           iChannel0;
varying vec2                texCoord;

void mainImage(out vec4 o,vec2 u)
{
    o = texture2D(iChannel0,fract(u*=2./iResolution.xy))
        * vec4(u.x>1.==u.y<1., u.x>1., u.y<1., 1);
}

void main() {
	mainImage(gl_FragColor, texCoord * iResolution.xy);
}