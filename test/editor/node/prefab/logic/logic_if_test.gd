# GdUnit generated TestSuite
class_name LogicIfTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://src/editor/node/prefab/logic/logic_if.gd'


func test_execute() -> void:
	var if_node = load(__source).new()
	if_node.free()
