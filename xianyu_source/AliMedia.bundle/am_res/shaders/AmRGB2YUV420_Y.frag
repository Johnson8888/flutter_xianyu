uniform sampler2D AM_Tex0;

varying vec2 v_texCoords[4];

float RGBToY(vec3 color)
{
    return dot(vec3(0.299, 0.587, 0.114), color);
}

void main()
{
    float y0 = RGBToY(texture2D(AM_Tex0, v_texCoords[0]).rgb);
    float y1 = RGBToY(texture2D(AM_Tex0, v_texCoords[1]).rgb);
    float y2 = RGBToY(texture2D(AM_Tex0, v_texCoords[2]).rgb);
    float y3 = RGBToY(texture2D(AM_Tex0, v_texCoords[3]).rgb);
    
    gl_FragColor = vec4(y0, y1, y2, y3);
}
