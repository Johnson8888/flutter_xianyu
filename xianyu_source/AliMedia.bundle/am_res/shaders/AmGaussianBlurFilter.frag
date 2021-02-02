varying vec2  v_texCoord;

uniform  vec2 offset;
uniform  vec2 blurSize;
void main() {
    vec2 myOffset = offset * vec2(blurSize);
    LOWP vec4 sum = vec4(0.0);

    vec3 Guass = vec3(0.05448868,0.24420134,0.40261995);

    sum += texture2D(AM_Tex1, v_texCoord + (-2.0 * myOffset)) * Guass.x;
    sum += texture2D(AM_Tex1, v_texCoord + (-1.0 * myOffset)) * Guass.y;
    sum += texture2D(AM_Tex1, v_texCoord + (0.0 * myOffset)) * Guass.z;
    sum += texture2D(AM_Tex1, v_texCoord + (1.0 * myOffset)) * Guass.y;
    sum += texture2D(AM_Tex1, v_texCoord + (2.0 * myOffset)) * Guass.x;
    gl_FragColor = sum;                                                        
}
