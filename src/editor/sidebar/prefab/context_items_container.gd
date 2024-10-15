extends NodeItemsContainer

func _ready() -> void:
	set_title("Context")
	set_items(_load_items_from_path(EnvironmentSingleton.mod_path))

func _load_items_from_path(path: StringName) -> Dictionary:
	if path.is_empty(): 
		printerr("ContextItemsContainer: Items path is empty")
		return {}
	
	path = path + "/nodes/"
	var dir := DirAccess.open(path)
	
	if not dir:
		printerr("ContextItemsContainer: Error trying to access path ", path)
		return {}
		
	var items: Dictionary = {}
	
	dir.list_dir_begin()
	var filename := dir.get_next()
	
	while filename != "":
		var scene_path = path + filename
		if scene_path.contains(".tscn"):
			scene_path = scene_path.replace(".remap", "")
		
			var scene := ResourceLoader.load(scene_path)
			var _node: RoutineNode = scene.instantiate()
			items[_node.keyword.to_pascal_case()] = scene
			_node.queue_free()
			
		filename = dir.get_next()
	
	return items
