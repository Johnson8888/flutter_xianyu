attribute vec4 a_position;
attribute vec2 a_texcoord0;
attribute LOWP vec4 a_color0;

varying LOWP vec4 v_color;

uniform mat4 u_mvp;

void main()
{
    v_color = vec4(a_color0.rgb * a_color0.a , a_color0.a);
    
    gl_PointSize = a_texcoord0.x;
    gl_Position = u_mvp*a_position;
}

