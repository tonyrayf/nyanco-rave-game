/// @param {real}  blend_spd  Скорость изменения бленда
/// @param {real}  blend_min  Минимум бленда
/// @description			  Стандартная функция кнопок с блендом и клик, степ функциями (требует их наличия у объекта кнопки)

function button_default_func(blend_spd, blend_min)
{
	if (place_meeting(x, y, obj_shoot_area)) //Наведение на кнопку
	{
		blend -= blend_spd; //Затемнение кнопки при наведении
		
		if (mouse_check_button_released(mb_left))
		{
			click_func();
			audio_play_sound(snd_button_click, 100, false);
		}
	}
	else
	{
		blend += blend_spd; //Осветление кнопки при не-наведении
	}

	step_func();

	//Ставим оттенок
	blend = clamp(blend, blend_min, 255);
	image_blend = make_color_rgb(blend, blend, blend);
}