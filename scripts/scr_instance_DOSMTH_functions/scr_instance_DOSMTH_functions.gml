/// @param {array}  objs  Массив объектов для включения

function instance_activate_objects(objs)
{
	var i = 0;
	repeat (array_length(objs))
	{
		instance_activate_object(objs[i++]);
	}
}


/// @param {array}  objs  Массив объектов для выключения

function instance_deactivate_objects(objs)
{
	var i = 0;
	repeat (array_length(objs))
	{
		instance_deactivate_object(objs[i++]);
	}
}


/// @param {array}  objs  Массив объектов для уничтожения

function instance_destroy_objects(objs)
{
	var i = 0;
	repeat (array_length(objs))
	{
		instance_destroy(objs[i++]);
	}
}