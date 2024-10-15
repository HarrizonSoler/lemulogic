extends NodeItemsContainer

const items: Dictionary = {
	"Print": preload("res://ui/editor/node/prefab/base/base_print.tscn"),
	"String": preload("res://ui/editor/node/prefab/base/base_string.tscn"),
	#"Example": preload("res://ui/editor/node/prefab/base/base_example.tscn")
}

func _ready() -> void:
	set_title("Base")
	set_items(items)
