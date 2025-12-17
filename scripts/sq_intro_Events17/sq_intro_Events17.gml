// Auto-generated stubs for each available event.

function sq_intro_event_create()
{

}

function sq_intro_event_destroy()
{

}

function sq_intro_event_clean_up()
{

}

function sq_intro_event_step()
{
	
}

function sq_intro_event_step_begin()
{
	var seq = layer_get_all_elements("Intro")[0];
	layer_sequence_x(seq, Camera.x - Camera.half_view_width);
	layer_sequence_y(seq, Camera.y - Camera.half_view_height);
}

function sq_intro_event_step_end()
{
	
}

function sq_intro_event_async_system()
{

}



function sq_intro_Moment()
{
	layer_destroy("Intro");
}