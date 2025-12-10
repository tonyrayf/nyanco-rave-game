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

function get_inst_from_seq_by_name(_seq_element_id, _inst_name)
{
    // Получаем структуру экземпляра последовательности
    var _seq_instance_struct = layer_sequence_get_instance(_seq_element_id);
    if (!is_struct(_seq_instance_struct)) {
        return noone;
    }
    // Получаем массив активных треков
    var _active_tracks = _seq_instance_struct.activeTracks;
    for (var i = 0; i < array_length(_active_tracks); i++) {
        var _track = _active_tracks[i];

        // Проверяем, является ли трек треком объекта и соответствует ли имя
        if (variable_struct_exists(_track, "instanceID")) {
            var _instance_id = _track.instanceID;
            // Проверяем, существует ли экземпляр и его имя совпадает с нужным
            if (instance_exists(_instance_id) && _track.track.name == _inst_name) {
                return _instance_id;
            }
        }
    }
    return noone; // Экземпляр не найден
}