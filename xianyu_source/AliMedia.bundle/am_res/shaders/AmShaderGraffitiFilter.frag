uniform sampler2D AM_Tex0;
uniform float fWhichTypeOfDrawing;
varying vec2 v_texCoord;
varying vec2 leftTextureCoordinate;
varying vec2 rightTextureCoordinate;

varying vec2 topTextureCoordinate;
varying vec2 topLeftTextureCoordinate;
varying vec2 topRightTextureCoordinate;

varying vec2 bottomTextureCoordinate;
varying vec2 bottomLeftTextureCoordinate;
varying vec2 bottomRightTextureCoordinate;

const float threshold = 0.5;
const vec3 color = vec3(1.0, 0.3333, 0.0);
const vec3 W = vec3(0.2125, 0.7154, 0.0721);

void main(){
    LOWP vec3 rgb = texture2D(AM_Tex0, v_texCoord).rgb;
    float luminance = dot(rgb, W);
    
    if (fWhichTypeOfDrawing > 0.5)
    {
        rgb = texture2D(AM_Tex0, leftTextureCoordinate).rgb;
        float leftIntensity = dot(rgb, W);
        rgb = texture2D(AM_Tex0, rightTextureCoordinate).rgb;
        float rightIntensity = dot(rgb, W);
        
        rgb = texture2D(AM_Tex0, topTextureCoordinate).rgb;
        float topIntensity = dot(rgb, W);
        rgb = texture2D(AM_Tex0, topLeftTextureCoordinate).rgb;
        float topLeftIntensity = dot(rgb, W);
        rgb = texture2D(AM_Tex0, topRightTextureCoordinate).rgb;
        float topRightIntensity = dot(rgb, W);
        
        rgb = texture2D(AM_Tex0, bottomTextureCoordinate).rgb;
        float bottomIntensity = dot(rgb, W);
        rgb = texture2D(AM_Tex0, bottomLeftTextureCoordinate).rgb;
        float bottomLeftIntensity = dot(rgb, W);
        rgb = texture2D(AM_Tex0, bottomRightTextureCoordinate).rgb;
        float bottomRightIntensity = dot(rgb, W);
        
        float h = -topLeftIntensity - 2.0 * topIntensity - topRightIntensity + bottomLeftIntensity + 2.0 * bottomIntensity + bottomRightIntensity;
        float v = -bottomLeftIntensity - 2.0 * leftIntensity - topLeftIntensity + bottomRightIntensity + 2.0 * rightIntensity + topRightIntensity;
        float mag = length(vec2(h, v));
        float thresholdTest = 1.0 - step(threshold, mag);
        
        gl_FragColor = vec4(mix(vec3(luminance), vec3(color.r, color.g, color.b), 0.5) * thresholdTest, 1.0);
        
    }
    else
    {
        gl_FragColor = vec4(vec3(luminance), 1.0);
    }
}
