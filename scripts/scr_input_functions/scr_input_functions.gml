/// @param {array}  keys  Массив клавиш для проверки
/// @description          Проверяет на зажатие несколько указанных клавиш

function key_input_check(keys)
{
	var i = 0;
	repeat (array_length(keys))
	{
		if (not is_mouse_button(keys[i]))
		{
			if (keyboard_check(keys[i++])) return true;
		}
		else
		{
			if (mouse_check_button(keys[i++])) return true;
		}
	}
	return false;
}


/// @param {array}  keys  Массив клавиш для проверки
/// @description          Проверяет на нажатие несколько указанных клавиш

function key_input_check_pressed(keys)
{
	var i = 0;
	repeat (array_length(keys))
	{
		if (not is_mouse_button(keys[i]))
		{
			if (keyboard_check_pressed(keys[i++])) return true;
		}
		else
		{
			if (mouse_check_button_pressed(keys[i++])) return true;
		}
	}
	return false;
}


/// @param {array}  keys  Массив клавиш для проверки
/// @description          Проверяет на разжатие несколько указанных клавиш

function key_input_check_released(keys)
{
	var i = 0;
	repeat (array_length(keys))
	{
		if (not is_mouse_button(keys[i]))
		{
			if (keyboard_check_released(keys[i++])) return true;
		}
		else
		{
			if (mouse_check_button_released(keys[i++])) return true;
		}
	}
	return false;
}

function is_mouse_button(key)
{
    switch (key)
    {
        case mb_any:
        case mb_left:
        case mb_middle:
        case mb_none:
        case mb_right:
        case mb_side1:
        case mb_side2:
            return true;
        default:
            return false;
    }
}