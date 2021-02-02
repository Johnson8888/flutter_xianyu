attribute vec4 a_position;
attribute vec2 a_texcoord0;


varying MEDIUMP vec2 v_texCoord;
varying MEDIUMP vec2 st;


void main()
{
    gl_Position = a_position;
    v_texCoord = a_texcoord0;
    st = a_position.xy * 0.5 + 0.5;
}
