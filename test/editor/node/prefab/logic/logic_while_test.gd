# GdUnit generated TestSuite
class_name LogicWhileTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://src/editor/node/prefab/logic/logic_while.gd'


func test_execute() -> void:
	var while_node = load(__source).new()
	while_node.free()
