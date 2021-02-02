attribute vec4 a_position;
attribute vec4 a_color0;

varying LOWP vec4 v_color;

void main()
{
    v_color = vec4(a_color0.rgb * a_color0.a , a_color0.a);
    gl_Position = a_position;
}

