# GdUnit generated TestSuite
class_name LogicForTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://src/editor/node/prefab/logic/logic_for.gd'


func test_execute() -> void:
	var for_node = load(__source).new()
	for_node.free()
