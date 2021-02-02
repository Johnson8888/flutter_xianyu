uniform sampler2D AM_Tex0;
varying vec2 v_texCoord;

void main()
{
    LOWP vec3 rgb = texture2D(AM_Tex0, v_texCoord).rgb;
    LOWP vec3 rgb2 = texture2D(AM_Tex0, v_texCoord+0.015).rgb;
    gl_FragColor = vec4(rgb.r, rgb2.g, rgb2.b, 1.0);
}
