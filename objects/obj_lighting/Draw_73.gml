var cam = view_camera[0]; // или camera_get_active() если кастом камера
var vx = camera_get_view_x(cam);
var vy = camera_get_view_y(cam);
var vw = camera_get_view_width(cam);
var vh = camera_get_view_height(cam);

if (!surface_exists(light_surf))
{
    light_surf = surface_create(vw, vh);
}
else
{
    surface_set_target(light_surf);
	
    draw_set_alpha(0.99);
    draw_rectangle_colour(0, 0, vw, vh, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    
    gpu_set_blendmode(bm_subtract);
    with (obj_par_light)
	{
        var lx = x - vx;
        var ly = y - vy;
        draw_sprite_ext(sprite_index, -1, lx, ly, image_xscale, image_yscale, 0, c_white, 1);
    }
    gpu_set_blendmode(bm_normal);
    
    surface_reset_target();
    
    draw_surface(light_surf, vx, vy);
}