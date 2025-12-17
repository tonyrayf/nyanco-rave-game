varying vec2 v_vTexcoord;
uniform float u_time;

void main() {
    vec4 base = texture2D(gm_BaseTexture, v_vTexcoord);
    //float gray = dot(base.rgb, vec3(0.299, 0.587, 0.114));
    float gray = dot(base.rgb, vec3(2.0, 2.0, 2.0));
	
    // Однородный белый тепловизор
    vec3 thermal = vec3(gray * 1.8 + 0.3);

    // CRT-шум (кинескоп)
    float n = fract(sin(dot(v_vTexcoord * 500.0 + u_time * 50.0, vec2(12.9898, 78.233))) * 43758.5);
    thermal += (n - 0.5) * 0.2;

    // Чёткие контуры
    float edge = length(vec2(dFdx(gray), dFdy(gray))) * 18.0;
    thermal += vec3(edge);
	
    // Яркая подсветка врагов #EE1C24
    float enemy = step(0.85, base.r) * step(base.g + base.b, 0.4);
    thermal += vec3(3.0) * enemy;

    gl_FragColor = vec4(thermal, 1.0);
}