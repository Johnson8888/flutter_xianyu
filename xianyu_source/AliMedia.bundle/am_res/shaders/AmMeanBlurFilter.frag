uniform sampler2D AM_Tex0;
varying vec2 v_texCoord;

uniform float texelWidthOffset;
uniform float texelHeightOffset;

void main() {
    vec2 singleStepOffset = vec2(texelWidthOffset, texelHeightOffset);
    
    LOWP vec4 sum = texture2D(AM_Tex0, v_texCoord);
    sum += texture2D(AM_Tex0, v_texCoord - singleStepOffset);
    sum += texture2D(AM_Tex0, v_texCoord + singleStepOffset);
    sum += texture2D(AM_Tex0, v_texCoord - 2.0*singleStepOffset);
    sum += texture2D(AM_Tex0, v_texCoord + 2.0*singleStepOffset);
    sum += texture2D(AM_Tex0, v_texCoord - 3.0*singleStepOffset);
    sum += texture2D(AM_Tex0, v_texCoord + 3.0*singleStepOffset);
    sum += texture2D(AM_Tex0, v_texCoord - 4.0*singleStepOffset);
    sum += texture2D(AM_Tex0, v_texCoord + 4.0*singleStepOffset);
    
    gl_FragColor = sum / 9.0;
}
