uniform sampler2D AM_Tex0;
uniform float time;
uniform highp vec2 frameSize;
varying vec2 v_texCoord;
varying vec2 st;

const float PI = 3.14159265359;

vec3 sRadon(vec3 x)
{
    return mod(((x * 35.4) + 1.0) * x, vec3(285.8));
}

float generateNoise(vec2 v)
{
    const vec4 C = vec4(0.210375, 0.356124, -0.586522, 0.030001);
    vec2 i = floor(v + dot(v, C.yy));
    vec2 x0 = v - i + dot(i, C.xx);
    vec2 i1;
    i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    vec4 x12 = x0.xyxy + C.xxzz;
    x12.xy -= i1;
    i = mod(i, vec2(285.8));
    vec3 p = sRadon(sRadon(i.y + vec3(0.0, i1.y, 1.0)) + i.x + vec3(0.0, i1.x, 1.0));
    vec3 m = max(0.5 - vec3(dot(x0, x0), dot(x12.xy, x12.xy), dot(x12.zw, x12.zw)), 0.0);
    m = m * m;
    m = m * m;
    vec3 x = 2.0 * fract(p * C.www) - 1.0;
    vec3 h = abs(x) - 0.5;
    vec3 ox = floor(x + 0.5);
    vec3 a0 = x - ox;
    m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);
    vec3 g;
    g.x = a0.x * x0.x + h.x * x0.y;
    g.yz = a0.yz * x12.xz + h.yz * x12.yw;
    return 128.0 * dot(m, g);
}

float sFuncexp(float x, float cyclePeriod, float onThreshold)
{
    float xx = (mod(x, cyclePeriod) - cyclePeriod + onThreshold) / onThreshold;
    float y = xx * xx * xx;
    return step(cyclePeriod - onThreshold, mod(x, cyclePeriod)) * y;
}

void main(){
    float fastNoise = generateNoise(vec2(sin(time) * 50.));
    float slowNoise = clamp(abs(generateNoise(vec2(time / 20., 0.))), 0., 1.);
    float w1 = sFuncexp(time, 10.8, 0.5);
    float w2 = sFuncexp(time - 3.3, 10.8, 0.5);
    float w3 = sFuncexp(time - 7.5, 10.8, 0.5);
    float distorsion1 = 1. + step(2.95, mod(time + 97.9, 3.23)) * (abs(sin(PI * 12.5 * (time + 100.))) * 40.) * (slowNoise + .3) + (w1 * 50. + w3 * 50.) * fastNoise;
    float distOffset = -generateNoise(vec2((st.y - time) * 3., 0.0)) * .2;
    distOffset = distOffset * distOffset * distOffset * distorsion1 * distorsion1 + generateNoise(vec2((st.y - time) * 50., 0.0)) * ((w2 * 50.) * fastNoise) * .001;
    vec2 finalDistOffset = vec2(fract(st.x + distOffset), fract(st.y - time * w3 * 50. * fastNoise));
    vec2 offset = ((step(4., mod(time, 5.)) * abs(sin(PI * time)) / 4.) * slowNoise + w2 * 5. * fastNoise) * vec2(cos(-.5784902357984), sin(-.5784902357984));
    vec4 cr = texture2D(AM_Tex0, finalDistOffset + offset);
    vec4 cg = texture2D(AM_Tex0, finalDistOffset);
    vec4 cb = texture2D(AM_Tex0, finalDistOffset - offset);
    vec3 color = vec3(cr.r, cg.g, cb.b);
    vec2 sc = vec2(cos((st.x+st.y)*0.5 * 800.), sin((st.x+st.y)*0.5 * 800.));
    //vec2 sc = vec2(sin(st.y * 800.), cos(st.y * 800.));//dy
    vec3 copy = color + color * vec3(sc.x, sc.y, sc.x) * .5;
    color = mix(color, copy, .4);
    vec2 smt = floor(frameSize * st / vec2(4. * st / st));
    vec4 snow = vec4(abs(fract(sin(dot(smt * time, vec2(1.501, 27.984))) * 567.8976)) * (abs(slowNoise) / 5. + (w1 * 1. + w2 * 5. + w3 * 10.) * fastNoise));
    color += vec3(snow);
    gl_FragColor.rgb = color;
}
