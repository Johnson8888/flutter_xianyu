uniform sampler2D AM_Tex0;
uniform sampler2D AM_Tex1;

varying vec2  v_texCoord;

uniform float uniAlpha;

void main()
{
    vec4 textureColor = texture2D(AM_Tex0, v_texCoord);
    
    float blueColor = textureColor.b * 63.0;
    
    vec2 quad1;
    quad1.y = floor(floor(blueColor) / 8.0);
    quad1.x = floor(blueColor) - (quad1.y * 8.0);
    
    vec2 quad2;
    quad2.y = floor(ceil(blueColor) /8.0);
    quad2.x = ceil(blueColor) - (quad2.y * 8.0);
    
    vec2 texPos1;
    texPos1.x = (quad1.x * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.r);
    texPos1.y = (quad1.y * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.g);
    
    //texPos1.x = 1.0 - texPos1.x;
    texPos1.y = 1.0 - texPos1.y;
    
    vec2 texPos2;
    texPos2.x = (quad2.x * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.r);
    texPos2.y = (quad2.y * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.g);
    
    //texPos2.x = 1.0 - texPos2.x;
    texPos2.y = 1.0 - texPos2.y;
    
    LOWP vec4 newColor1 = texture2D(AM_Tex1, texPos1);
    LOWP vec4 newColor2 = texture2D(AM_Tex1, texPos2);
    
    LOWP vec4 newColor = mix(newColor1, newColor2, fract(blueColor));
    
    gl_FragColor = vec4(mix(textureColor.rgb, newColor.rgb, uniAlpha), textureColor.a);
}
