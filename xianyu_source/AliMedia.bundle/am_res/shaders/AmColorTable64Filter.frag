uniform sampler2D AM_Tex0;
uniform sampler2D AM_Tex1;

varying vec2 v_texCoord;
uniform float intensity;

void main()
{
    vec4 textureColor = texture2D(AM_Tex0,  v_texCoord);
    
    float blueColor = textureColor.b * 15.0;
    
    vec2 quad1;
    quad1.y = floor(floor(blueColor) / 4.0);
    quad1.x = floor(blueColor) - (quad1.y * 4.0);
    vec2 quad2;
    quad2.y = floor(ceil(blueColor) / 4.0);
    quad2.x = ceil(blueColor) - (quad2.y * 4.0);
    
    vec2 texPos1;
    texPos1.x = (quad1.x * 0.25) + 0.5/64.0 + ((0.25 - 1.0/64.0) * textureColor.r);
    texPos1.y = (quad1.y * 0.25) + 0.5/64.0 + ((0.25 - 1.0/64.0) * textureColor.g);
    texPos1.y = texPos1.y;
    
    vec2 texPos2;
    texPos2.x = (quad2.x * 0.25) + 0.5/64.0 + ((0.25 - 1.0/64.0) * textureColor.r);
    texPos2.y = (quad2.y * 0.25) + 0.5/64.0 + ((0.25 - 1.0/64.0) * textureColor.g);
    texPos2.y = texPos2.y;
    
    LOWP vec4 newColor1 = texture2D( AM_Tex1, texPos1);
    LOWP vec4 newColor2 = texture2D( AM_Tex1, texPos2);
    
    LOWP vec4 newColor = mix(newColor1, newColor2, fract(blueColor));
    gl_FragColor = mix(textureColor, vec4(newColor.rgb, textureColor.w), intensity);
}
