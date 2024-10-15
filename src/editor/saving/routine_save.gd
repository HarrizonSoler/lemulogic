extends Resource

@export var graph: PackedScene
@export var connections: Array[Dictionary]
@export var variables: Array[StringName]
@export var node_id_count: int

func set_params(_graph: PackedScene, _connections: Array[Dictionary], _variables: Array[StringName], _node_id_count: int) -> void:
	graph = _graph
	connections = _connections
	variables = _variables
	node_id_count = _node_id_count
