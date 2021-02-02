attribute vec4 a_position;
attribute vec2 a_texcoord0;

uniform mat4 u_textureMatrix;

varying MEDIUMP vec2 v_texCoord;

void main()
{
    gl_Position = a_position;
    v_texCoord = (u_textureMatrix*vec4(a_texcoord0,0,1)).xy;
}

