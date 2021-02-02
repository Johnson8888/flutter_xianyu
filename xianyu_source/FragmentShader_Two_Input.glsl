varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;
void main()
{
    lowp vec4 originColor = texture2D(inputImageTexture, textureCoordinate);
    lowp vec3 newColor;
    newColor.r = texture2D(inputImageTexture2, vec2(originColor.r,0.0)).r;
    newColor.g = texture2D(inputImageTexture2, vec2(originColor.g,0.0)).g;
    newColor.b = texture2D(inputImageTexture2, vec2(originColor.b,0.0)).b;
    gl_FragColor = vec4(newColor, 1.0);
}
