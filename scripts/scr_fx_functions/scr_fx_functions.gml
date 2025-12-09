/// @param {real}  depth  Depth слоя размытия
/// @description		  Создаёт слой размытия на указанной глубине

function create_blur_layer(_depth)
{
	layer_create(_depth, "Blur");
	var fx = fx_create("_filter_large_blur");
	layer_set_fx("Blur", fx);
	fx_set_parameter(fx, "g_Radius", 1.3);
}