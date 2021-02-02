uniform sampler2D AM_Tex0;
uniform sampler2D AM_Tex1;
uniform sampler2D AM_Tex2;

varying vec2 v_texCoord;
varying vec2 v_texCoord1;
 
uniform float blurAlpha;
uniform float widthOffset;
uniform float heightOffset;
uniform float u_sharpen;

void main()
{
    LOWP vec4 iColor = texture2D(AM_Tex1, v_texCoord1);
    LOWP vec4 meanColor = texture2D(AM_Tex2, v_texCoord);
    LOWP vec4 varColor = texture2D(AM_Tex0, v_texCoord);
    float p = clamp((min(iColor.r, meanColor.r - 0.1) - 0.2) * 4.0, 0.0, 1.0);
    float meanVar = (varColor.r + varColor.g + varColor.b) / 3.0;
    
    float kMin = (0.11 / (meanVar + 0.1) - meanVar * 0.4) * p * blurAlpha;
    LOWP vec3 resultColor = mix(iColor.rgb, meanColor.rgb, kMin);
    
    vec2 myOffset1 = vec2(widthOffset, 0);
    vec2 myOffset2 = vec2(0, heightOffset);
    LOWP vec4 sum = vec4(0.0);
    
    vec3 Guass = vec3(0.05448868,0.24420134,0.40261995);
    float scale = 2.79214;
    //float scale = 8.0 * Guass.x + 8.0 * Guass.y + Guass.z;
    
    sum += texture2D(AM_Tex1, v_texCoord1) * Guass.z;
    
    sum += texture2D(AM_Tex1, v_texCoord1 + (-1.0 * vec2(widthOffset, 0))) * Guass.y;
    sum += texture2D(AM_Tex1, v_texCoord1 + (1.0 * vec2(widthOffset, 0))) * Guass.y;
    
    sum += texture2D(AM_Tex1, v_texCoord1 + (-1.0 * vec2(0, heightOffset))) * Guass.y;
    sum += texture2D(AM_Tex1, v_texCoord1 + (1.0 * vec2(0, heightOffset))) * Guass.y;
    
    sum += texture2D(AM_Tex1, v_texCoord1 + (-1.0 * vec2(widthOffset, heightOffset))) * Guass.y;
    sum += texture2D(AM_Tex1, v_texCoord1 + (1.0 * vec2(widthOffset, heightOffset))) * Guass.y;
    
    sum += texture2D(AM_Tex1, v_texCoord1 + (vec2(-1.0, 1.0) * vec2(widthOffset, heightOffset))) * Guass.y;
    sum += texture2D(AM_Tex1, v_texCoord1 + (vec2(1.0, -1.0) * vec2(widthOffset, heightOffset))) * Guass.y;
    
    sum += texture2D(AM_Tex1, v_texCoord1 + (-2.0 * vec2(widthOffset, 0))) * Guass.x;
    sum += texture2D(AM_Tex1, v_texCoord1 + (2.0 * vec2(widthOffset, 0))) * Guass.x;
    
    sum += texture2D(AM_Tex1, v_texCoord1 + (-2.0 * vec2(0, heightOffset))) * Guass.x;
    sum += texture2D(AM_Tex1, v_texCoord1 + (2.0 * vec2(0, heightOffset))) * Guass.x;
    
    sum += texture2D(AM_Tex1, v_texCoord1 + (-2.0 * vec2(widthOffset, heightOffset))) * Guass.x;
    sum += texture2D(AM_Tex1, v_texCoord1 + (2.0 * vec2(widthOffset, heightOffset))) * Guass.x;
    
    sum += texture2D(AM_Tex1, v_texCoord1 + (vec2(-2.0, 2.0) * vec2(widthOffset, heightOffset))) * Guass.x;
    sum += texture2D(AM_Tex1, v_texCoord1 + (vec2(2.0, -2.0) * vec2(widthOffset, heightOffset))) * Guass.x;
    
    resultColor = resultColor.rgb + u_sharpen*(iColor.rgb - sum.rgb / scale);
    
    gl_FragColor =  vec4(resultColor, 1.0);
}
