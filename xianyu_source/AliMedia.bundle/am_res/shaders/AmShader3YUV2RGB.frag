uniform sampler2D AM_Tex0;
uniform sampler2D AM_Tex1;
uniform sampler2D AM_Tex2;
varying vec2 v_texCoord;

uniform mat3 u_colorConversionMatrix;

void main()
{
    LOWP vec3 yuvColor;
    yuvColor.x = texture2D(AM_Tex0, v_texCoord).r;
    yuvColor.y = texture2D(AM_Tex1, v_texCoord).r - 0.5;
    yuvColor.z = texture2D(AM_Tex2, v_texCoord).r - 0.5;
    
    LOWP vec3 rgbColor = u_colorConversionMatrix * yuvColor;
    
    gl_FragColor.rgb = rgbColor;
}
