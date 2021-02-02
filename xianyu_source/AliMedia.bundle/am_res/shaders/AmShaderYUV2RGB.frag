uniform sampler2D AM_Tex0;
uniform sampler2D AM_Tex1;
varying vec2 v_texCoord;

uniform mat3 u_colorConversionMatrix;

void main()
{
    LOWP vec3 yuvColor;
    yuvColor.x = texture2D(AM_Tex0, v_texCoord).r;
    yuvColor.yz = texture2D(AM_Tex1, v_texCoord).rg - vec2(0.5, 0.5);
    
    vec3 rgbColor = u_colorConversionMatrix * yuvColor;
    
    gl_FragColor.rgb = rgbColor;
}
