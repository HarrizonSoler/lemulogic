extends NodeItemsContainer

const items: Dictionary = {
	"Number": preload("res://ui/editor/node/prefab/math/math_number.tscn"),
	"Operation": preload("res://ui/editor/node/prefab/math/math_operation.tscn")
}

func _ready() -> void:
	set_title("Math")
	set_items(items)
