uniform sampler2D AM_Tex0;
varying vec2 v_texCoord;

void main()
{
    vec4 oriColor = texture2D(AM_Tex0, v_texCoord);
    
    LOWP vec3 yuv;
    yuv.r = oriColor.r * 0.299 + 0.587 * oriColor.g + 0.114 * oriColor.b;
    yuv.g = 0.5 + (oriColor.b - yuv.r) / 1.772;
    yuv.b = 0.5 + (oriColor.r - yuv.r) / 1.402;
    gl_FragColor.rg = yuv.gb;
}
