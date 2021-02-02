//
//  QQRichGLFragmentShaderPortraitSmoothReal.glsl
//  QQMSFContact
//
//  Created by hodxiang on 16/8/24.
//
//

precision highp float;
varying vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;
uniform sampler2D inputImageTexture3;
uniform int width;
uniform int height;

void main()
{
    float whiten = 0.45;
    float skinFilter = 0.0;
    float smoothMag = 0.3;

    vec4 ini_color = texture2D(inputImageTexture, textureCoordinate);
    float tx = 1.0 / float(width);
    float ty = 1.0 / float(height);
    
    vec4 final = ini_color;
    vec4 ret;
    float a = ini_color.g-ini_color.a+0.5;
    a = clamp(a, 0.0001, 0.9999);
    ini_color.a = 1.0;
    
    float flag = step(a, 0.5);
    a = mix(a/(2.0*(1.0-a)), 1.0 - (1.0-a)/(2.0*a), flag);
    a = clamp(a, 0.0001, 0.9999);
    a = mix(a/(2.0*(1.0-a)), 1.0 - (1.0-a)/(2.0*a), flag);
    a = clamp(a, 0.0001, 0.9999);
    a = mix(a/(2.0*(1.0-a)), 1.0 - (1.0-a)/(2.0*a), flag);
    a = clamp(a, 0.0, 1.0);
    
    if(a>0.2)
        a = pow((a-0.2)*1.25, 0.5)/1.25+0.2;
    a = 1.0-a;
    
    vec4 tmp4;
    tmp4.a = 1.0;
    
    tmp4.r = texture2D(inputImageTexture2, vec2(ini_color.r,0.0)).r;
    tmp4.g = texture2D(inputImageTexture2, vec2(ini_color.g,0.0)).b;
    tmp4.b = texture2D(inputImageTexture2, vec2(ini_color.b,0.0)).g;
    //
    final = (ini_color + smoothMag*a*(tmp4-ini_color));
    
    a = 0.5;
    flag = step(0.5, a);
    
    vec4 color = mix((2.0*a*final), (1.0-2.0*(1.0-a)*(1.0-final)), flag);
    
    ret = 0.8*color+0.2*final;
    vec3 tmp;
    tmp.r = texture2D(inputImageTexture3, vec2(ret.r,0.0)).r;
    tmp.g = texture2D(inputImageTexture3, vec2(ret.g,0.0)).r;
    tmp.b = texture2D(inputImageTexture3, vec2(ret.b,0.0)).r;
    vec3 result= whiten*(tmp - ret.rgb)+ret.rgb;
    
    float cg1 = dot(vec3(-81.085,112.0,-30.915), final.rgb);
    float cr1 = dot(vec3(-37.797,-74.203,112.0), final.rgb);
    
    float cg = cg1+128.0-114.0;
    float cr = cr1+128.0-112.0;
    
    float v = max(sqrt(cg*cg+cr*cr)-14.0, 0.0);
    float s = pow(2.718281828459, -v/4.0);
    float gray = dot(vec3(0.3,0.6,0.1), final.rgb);
    float s1 = min(1.0, gray/0.25);
    s *= (s1*s1);
    
    s = min(1.0, s+1.0-skinFilter);
    
    gl_FragColor = vec4(s*result.rgb+(1.0-s)*ini_color.rgb, 1.0);
}
