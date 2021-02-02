attribute vec4 a_position;
attribute vec2 a_texcoord0;
attribute vec2 a_texcoord1;

varying MEDIUMP vec2 v_texCoord;
varying MEDIUMP vec2 v_texCoord1;

void main()
{
    gl_Position = a_position;
    v_texCoord = a_texcoord0;
    v_texCoord1 = a_texcoord1;
}
