uniform float u_PixelWidth;

uniform mat4 u_ImageMatrix;

attribute vec4 a_position;
attribute vec2 a_texcoord0;

varying MEDIUMP vec2 v_texCoords[4];

void main()
{
  vec2 l = (u_ImageMatrix * vec4(0, 0, 0, 1)).st;
  vec2 r = (u_ImageMatrix * vec4(1, 0, 0, 1)).st;

  vec2 offset = 0.5 * u_PixelWidth * (r - l);

  vec2 tex_coords = (u_ImageMatrix * vec4(a_texcoord0, 0, 1)).st;

  v_texCoords[0] = tex_coords - 3.0 * offset;
  v_texCoords[1] = tex_coords - offset;
  v_texCoords[2] = tex_coords + offset;
  v_texCoords[3] = tex_coords + 3.0 * offset;

  gl_Position = a_position;
}
