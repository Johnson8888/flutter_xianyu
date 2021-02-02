uniform sampler2D AM_Tex0;
varying vec2 v_texCoord;

uniform float fShadowAlpha;
uniform float fShadowScale;
void main()
{
    vec2 textureCoordForShadow = (v_texCoord - 0.5) / fShadowScale  + 0.5;
    
    LOWP vec3 rgb = texture2D(AM_Tex0, v_texCoord).rgb;
    LOWP vec3 rgbForShadow = texture2D(AM_Tex0, textureCoordForShadow).rgb;

    LOWP vec3 rgbForFinal = rgb * (1.0 - fShadowAlpha) + rgbForShadow * fShadowAlpha;

    gl_FragColor = vec4(rgbForFinal.rgb, 1.0);
}
