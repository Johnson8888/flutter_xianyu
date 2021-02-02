attribute vec4 a_position;
attribute vec2 a_texcoord0;

uniform mat4 u_mvp;

varying MEDIUMP vec2 v_texCoord;

void main()
{
    v_texCoord = a_texcoord0;
    gl_Position =  u_mvp*a_position;
}
