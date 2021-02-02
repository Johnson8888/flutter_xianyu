//
//  QQRichGLVertexShaderBase.glsl
//  QQMSFContact
//
//  Created by hodxiang on 16/8/24.
//
//

 attribute vec4 position;
 attribute vec2 inputTextureCoordinate;
 
 varying vec2 textureCoordinate;
 
 void main()
 {
     gl_Position = position;
     textureCoordinate = inputTextureCoordinate;
 }
