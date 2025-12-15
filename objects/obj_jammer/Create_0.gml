shader_jammer = sh_jammer;
u_center   = shader_get_uniform(shader_jammer, "u_center");
u_radius   = shader_get_uniform(shader_jammer, "u_radius");
u_strength = shader_get_uniform(shader_jammer, "u_strength");
u_time     = shader_get_uniform(shader_jammer, "u_time");

jammer_active = true;
radius = 200; strength = 1.5;

image_blend = c_dkgray;