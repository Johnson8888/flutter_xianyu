uniform sampler2D AM_Tex0;
uniform sampler2D AM_Tex1;

varying vec2 v_texCoord;
varying vec2 v_texCoord1;

void main()
{
    LOWP vec3 iColor = texture2D(AM_Tex1, v_texCoord1).rgb;
    LOWP vec3 meanColor = texture2D(AM_Tex0, v_texCoord).rgb;
    
    vec3 diffColor = (iColor - meanColor) * 7.07;
    diffColor = min(diffColor * diffColor, 1.0);
    
    float var = (diffColor.r + diffColor.g + diffColor.b) * 0.333;
    
    gl_FragColor = vec4(diffColor, 1.0);
}

