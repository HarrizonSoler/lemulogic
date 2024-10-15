extends NodeItemsContainer

const items: Dictionary = {
	"Bool": preload("res://ui/editor/node/prefab/logic/logic_bool.tscn"),
	"Comparison": preload("res://ui/editor/node/prefab/logic/logic_comparison.tscn"),
	"Evaluation": preload("res://ui/editor/node/prefab/logic/logic_evaluation.tscn"),
	"If": preload("res://ui/editor/node/prefab/logic/logic_if.tscn"),
	"While": preload("res://ui/editor/node/prefab/logic/logic_while.tscn"),
	"For": preload("res://ui/editor/node/prefab/logic/logic_for.tscn")
}

func _ready() -> void:
	set_title("Logic")
	set_items(items)
