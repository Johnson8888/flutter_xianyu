#extension GL_OES_EGL_image_external : require
precision mediump float;
varying vec2 v_texCoord;

uniform samplerExternalOES AM_Tex0;

void main() {
    gl_FragColor = texture2D(AM_Tex0, v_texCoord);
}
