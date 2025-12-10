hp = 100;

speed_x = 0;
speed_y = 0;

acceleration_g = 1;

setup = true;
enum states {
	Idle,
	Search,
	Detected
}
suspiciousness = 0;

current_state = states.Idle;
idle_to_search = 300;
search_to_detected = 180;
search_to_idle=1800;

idle_sus_return = 400;
search_sus_return = 600;

seq = layer_sequence_create(layer, x, y, sq_enemy_regular);
function get_inst_from_seq(_seq_element_id, _object_name) {
    // Получаем индекс объекта по его имени
    var _object_index = asset_get_index(_object_name);
    if (_object_index == -1) {
        return noone; // Объект с таким именем не найден
    }
    // Получаем структуру экземпляра последовательности
    var _seq_instance_struct = layer_sequence_get_instance(_seq_element_id);
    if (!is_struct(_seq_instance_struct)) {
        return noone;
    }
    // Получаем массив активных треков
    var _active_tracks = _seq_instance_struct.activeTracks;
    for (var i = 0; i < array_length(_active_tracks); i++) {
        var _track = _active_tracks[i];

        // Проверяем, является ли трек треком объекта и соответствует ли object_index
        if (variable_struct_exists(_track, "instanceID")) {
            var _instance_id = _track.instanceID;
            // Проверяем, существует ли экземпляр и его object_index
            if (instance_exists(_instance_id) && _instance_id.object_index == _object_index) {
                return _instance_id;
            }
        }
    }
    return noone; // Экземпляр не найден
}