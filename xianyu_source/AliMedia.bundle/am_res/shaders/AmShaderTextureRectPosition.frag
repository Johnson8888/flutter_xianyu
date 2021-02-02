uniform sampler2DRect AM_Tex0;
varying vec2 v_texCoord;
uniform vec2 texSize;

void main()
{
    gl_FragColor = texture2DRect(AM_Tex0, v_texCoord*texSize);
}


