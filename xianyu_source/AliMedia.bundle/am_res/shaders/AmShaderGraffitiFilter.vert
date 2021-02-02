attribute vec4 a_position;
attribute vec2 a_texcoord0;

uniform float shakeX;
uniform float texelWidthOffset;
uniform float texelHeightOffset;

varying MEDIUMP vec2 v_texCoord;
varying MEDIUMP vec2 leftTextureCoordinate;
varying MEDIUMP vec2 rightTextureCoordinate;

varying MEDIUMP vec2 topTextureCoordinate;
varying MEDIUMP vec2 topLeftTextureCoordinate;
varying MEDIUMP vec2 topRightTextureCoordinate;

varying MEDIUMP vec2 bottomTextureCoordinate;
varying MEDIUMP vec2 bottomLeftTextureCoordinate;
varying MEDIUMP vec2 bottomRightTextureCoordinate;

void main()
{
    gl_Position = a_position;
    v_texCoord = a_texcoord0;
    
    vec2 widthStep = vec2(texelWidthOffset, 0.0);
    vec2 heightStep = vec2(0.0, texelHeightOffset);
    vec2 widthHeightStep = vec2(texelWidthOffset, texelHeightOffset);
    vec2 widthNegativeHeightStep = vec2(texelWidthOffset, -texelHeightOffset);
    
    v_texCoord.x = v_texCoord.x+shakeX;
    
    leftTextureCoordinate = a_texcoord0.xy - widthStep;
    leftTextureCoordinate.x = leftTextureCoordinate.x+shakeX;
    
    rightTextureCoordinate = a_texcoord0.xy + widthStep;
    rightTextureCoordinate.x = rightTextureCoordinate.x+shakeX;
    
    topTextureCoordinate = a_texcoord0.xy - heightStep;
    topTextureCoordinate.x = topTextureCoordinate.x+shakeX;
    
    topLeftTextureCoordinate = a_texcoord0.xy - widthHeightStep;
    topLeftTextureCoordinate.x = topLeftTextureCoordinate.x+shakeX;
    
    topRightTextureCoordinate = a_texcoord0.xy + widthNegativeHeightStep;
    topRightTextureCoordinate.x = topRightTextureCoordinate.x+shakeX;
    
    bottomTextureCoordinate = a_texcoord0.xy + heightStep;
    bottomTextureCoordinate.x = bottomTextureCoordinate.x+shakeX;
    
    bottomLeftTextureCoordinate = a_texcoord0.xy - widthNegativeHeightStep;
    bottomLeftTextureCoordinate.x = bottomLeftTextureCoordinate.x+shakeX;
    
    bottomRightTextureCoordinate = a_texcoord0.xy + widthHeightStep;
    bottomRightTextureCoordinate.x = bottomRightTextureCoordinate.x+shakeX;
}
