/// @description  Функция плавности. Плавная в конце.

function ease_out_cubic(_x)
{
	return 1 - power((1 - _x), 3);
}


/// @description  Функция плавности. Плавная в начале и в конце (синусоида).

function ease_inout_sine(_x)
{
	return -(cos(pi * _x) - 1) / 2;
}