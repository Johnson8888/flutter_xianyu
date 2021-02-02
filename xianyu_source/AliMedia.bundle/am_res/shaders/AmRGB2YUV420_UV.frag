uniform sampler2D AM_Tex0;

varying vec2 v_texCoords[2];

vec2 RGBToCbCr(vec3 color)
{
    float u = dot(vec3(-0.169, -0.331,  0.500), color) + 0.5;
    float v = dot(vec3( 0.500, -0.419, -0.081), color) + 0.5;
    return vec2(u, v);
}

void main()
{
    vec2 uv0 = RGBToCbCr(texture2D(AM_Tex0, v_texCoords[0]).rgb);
    vec2 uv1 = RGBToCbCr(texture2D(AM_Tex0, v_texCoords[1]).rgb);
    
    gl_FragColor = vec4(uv0, uv1);
}

