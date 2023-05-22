varying vec2 v_vTexcoord;

uniform float u_fCutoffX;

void main() {
	vec4 fColor = vec4(1, 1, 1, texture2D(gm_BaseTexture, v_vTexcoord).a);
	if (gl_FragCoord.x <= u_fCutoffX)
		fColor.rgb = vec3(0, 0, 0);
		
	gl_FragColor = fColor;
}