draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(f_main);

draw_text_transformed_colour(Camera.x, Camera.y, "YOU DIED", 3, 3, 0, c_white, c_white, c_white, c_white, image_alpha - 0.6);
draw_text_transformed_colour(Camera.x, Camera.y + 80, "click to continue", 0.7, 0.7, 0, c_white, c_white, c_white, c_white, image_alpha - 2);