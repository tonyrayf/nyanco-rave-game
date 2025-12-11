/// @param {real}  _x    Значение переменной
/// @param {real}  _min  Минимальное значение
/// @param {real}  _max  Максимальное значение
/// @description		 Функция эффекта кодового замка

function wrap(_x, _min, _max)
{
	if (_x > _max) return _min;
	else if (_x < _min) return _max;
	else return _x;
}

// я даже незнаю почему это работает
function delta_mirror_direction(dir, surface_angle)
{
	return 2 * abs((surface_angle + (dir < surface_angle ? 0 : 360)) - dir);
}