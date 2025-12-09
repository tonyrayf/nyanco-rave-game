//Layer parameters
layer_alpha = 1;


//Layer function struct
func_struct = {
	inst_id : id,			  //layer object(my) id
	
	script_func : function()  //function that connects layer params
	{
		if (event_type == ev_draw and event_number == ev_draw_normal)
		{
			shader_set(sh_layer_alpha);
			shader_set_uniform_f(shader_get_uniform(sh_layer_alpha, "u_f_Alpha"), inst_id.layer_alpha);
		}
	}
}


//Set script
layer_script_begin (layer, func_struct.script_func);  delete func_struct;
layer_script_end
(
	layer,
	function() //Reset alpha shader
	{
		if (event_type == ev_draw and event_number == ev_draw_normal)
		{
			shader_reset();
		}
	}
);


Layers_manager.layers[? layer_get_name(layer)] = id; //Add to dsmap layer -- my id
