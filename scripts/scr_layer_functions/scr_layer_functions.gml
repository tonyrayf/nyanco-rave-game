/// @param {string}  _layer  Название слоя
/// @description             Возвращает айди объекта слоя

function layer_get_object_id(_layer)
{
	//Определение слова _layer есть id слоя
	return Layers_manager.layers[? _layer];
}


/// @param {string}  _layer  Название слоя
/// @param {real}    _alpha  Прозрачность слоя (от 0 до 1)
/// @description             Устанавливает прозрачность слою с помощью объекта слоя

function layer_set_alpha(_layer, _alpha)
{
	layer_get_object_id(_layer).layer_alpha = _alpha;
}