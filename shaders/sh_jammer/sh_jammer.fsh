varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2  u_center;     // центр помех в UV (0-1)
uniform float u_radius;     // радиус поля (0.1-0.5)
uniform float u_strength;   // сила помех (0.5-2.0)
uniform float u_time;       // анимация

float noise(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
    vec2 uv = v_vTexcoord;
    vec4 tex = texture2D(gm_BaseTexture, uv);
    
    vec2 dir = uv - u_center;
    float dist = length(dir);
    
    if (dist > u_radius) {
        gl_FragColor = tex * v_vColour;
        return;
    }
    
    // Радиальные волны (круговые помехи)
    float wave = sin(dist * 20.0 - u_time * 8.0) * 0.1 * u_strength;
    
    // Distortion UV (искажение текстуры)
    vec2 distorted_uv = uv + dir * wave * 0.05;
    tex = texture2D(gm_BaseTexture, distorted_uv);
    
    // Шум помех
    float n = noise(uv * 50.0 + u_time * 3.0) * 0.3 * u_strength * (1.0 - dist / u_radius);
    tex.rgb += n;
    
    // Scanlines + grayscale для "TV помех"
    float scan = sin(uv.y * 300.0 + u_time * 20.0) * 0.15 * u_strength;
    tex.rgb = mix(tex.rgb, vec3(dot(tex.rgb, vec3(0.3, 0.59, 0.11))), 0.4);
    tex.rgb += scan;
    
    // Fade по радиусу (центр ярче)
    float fade = 1.0 - smoothstep(0.0, u_radius, dist);
    tex.rgb *= fade * u_strength;
    
    gl_FragColor = tex * v_vColour;
}