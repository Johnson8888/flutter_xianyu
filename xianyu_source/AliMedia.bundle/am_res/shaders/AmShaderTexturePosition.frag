uniform sampler2D AM_Tex0;
varying vec2 v_texCoord;

void main()
{
    gl_FragColor = texture2D(AM_Tex0, v_texCoord);
}


