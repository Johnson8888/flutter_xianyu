#ifndef CONFIG_BONE_COUNT
#define CONFIG_BONE_COUNT 16
#endif // CONFIG_BONE_COUNT

#ifndef CONFIG_WEIGHT_COUNT
#define CONFIG_WEIGHT_COUNT 1
#endif // CONFIG_WEIGHT_COUNT

uniform mat4  u_BoneList[CONFIG_BONE_COUNT];

attribute vec4 a_position;
attribute vec2 a_texcoord0;

attribute vec4 a_joint;
attribute vec4 a_weight;

uniform mat4 u_mvp;

varying MEDIUMP vec2 v_texCoord;

vec4 Skin(vec4 position)
{
    vec4 skinned = vec4(0, 0, 0, 0);
    for (int i = 0; i < CONFIG_WEIGHT_COUNT; ++ i) {
        int index = int(a_joint[i]);
        skinned += a_weight[0] * u_BoneList[index] * position;
    }
    return skinned;
}

void main()
{
    v_texCoord = a_texcoord0;
    gl_Position = u_mvp * Skin(a_position);
}

