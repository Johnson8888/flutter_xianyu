uniform sampler2D AM_Tex0;
varying vec2 v_texCoord;

void main()
{
    LOWP vec4 oriColor = texture2D(AM_Tex0, v_texCoord);
    
    gl_FragColor.r = oriColor.r * 0.299 + 0.587 * oriColor.g + 0.114 * oriColor.b;
}
