precision highp float;

uniform vec3                iResolution;
uniform float               iGlobalTime;
uniform sampler2D           iChannel0;
varying vec2                texCoord;

#define MAGIC_FORMULA pow(abs(sin(iGlobalTime+0.1*rand(uv + iGlobalTime))*1.002), 600.)

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;


    // barrel distortion
    uv -= vec2(0.5);

    uv *= pow(length(uv), 0.15);

    uv += vec2(0.5);

    // fragment displacement (circular functions)
    uv.x += sin(uv.y*20.+iGlobalTime*10.)*0.01*MAGIC_FORMULA;

    uv.x += cos(uv.y*30.+iGlobalTime*10.)*0.01*MAGIC_FORMULA;

    uv.y += 0.2*MAGIC_FORMULA*sin(rand(vec2(iGlobalTime)));

    uv.y = mod(uv.y, 1.);

    // get texture data
    vec4 video_col = mix(texture2D(iChannel0, uv), vec4(0.7), 0.2*MAGIC_FORMULA);

    // dark bands
    video_col -= abs(sin(uv.y*100. + iGlobalTime*5.))*0.08;

    video_col -= abs(sin(uv.y*300. - iGlobalTime*10.))*0.05;

    // tv edges
    video_col -= vec4(pow(length(uv - vec2(0.5)), 0.5))*0.5;

    // signal noise
    video_col *= rand(uv + vec2(cos(iGlobalTime), sin(iGlobalTime)))*4.;

    // darken the final result a bit
    video_col -= 0.1;

    video_col += uv.y*vec4(0.5, 0.5, 1., 1.)/4.;
    video_col -= (1. - uv.y)*vec4(0.5, 1., 0.5, 1.)/8.;

    // send color to screen
	fragColor = video_col;
}

void main() {
	mainImage(gl_FragColor, texCoord * iResolution.xy);
}