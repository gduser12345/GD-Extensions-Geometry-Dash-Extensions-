uniform vec2 center; 
uniform vec2 resolution;
uniform float time;
uniform vec2 mouse; 
uniform float pulse1;
uniform float pulse2;
uniform float pulse3; 



#define PI 3.1415926535
#define TAU 6.2831853071

float line(vec2 A, vec2 B, vec2 C, float thickness) {
	vec2 AB = B-A;
    vec2 AC = C-A;

    float t = dot(AC, AB) / dot(AB, AB);
    t = min(1.0, max(0.0, t));
    
    vec2 Q = A + t * AB;
    
    float dist = length(Q-C);
    return smoothstep(-0.01, -dist, -thickness) + smoothstep(-0.02, dist, thickness);
}

void main(){
    vec2 uv = (gl_FragCoord-.5*resolution.xy)/resolution.y;

    vec3 color = vec3(0.0);
    
    for (int i = 0; i < 20; ++i) {
        float r = 0.5 - sin(time + float(i) * 0.8 * PI) * 0.1;
        float angle = time * 0.2 + float(i+1) * 0.1 * PI;

        vec2 dir = vec2(cos(angle), sin(angle)) * r;

        vec2 A = -dir * 0.5;
        vec2 B = -dir * 0.3;

        float t = time * 0.5 + float(i) * 0.1 * TAU;
        vec3 rgb = vec3(
        	sin(t		  ) * 0.5 + 0.5,
            sin(t + PI/2.0) * 0.5 + 0.5,
            sin(t + PI	  ) * 0.5 + 0.5
        );

        color += line(A, B, uv, 0.001) * rgb;        
    }
    
    
    color = color * 0.4 + sqrt(color*color / (color*color + 1.0)) * 0.6;

    gl_FragColor = vec4(vec3(color), 1.0);
}