# GdUnit generated TestSuite
class_name LogicBoolTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://src/editor/node/prefab/logic/logic_bool.gd'


func test_get_value() -> void:
	var bool_node = load(__source).new()
	bool_node.free()
