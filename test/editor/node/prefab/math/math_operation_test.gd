# GdUnit generated TestSuite
class_name MathOperationTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://src/editor/node/prefab/math/math_operation.gd'


func test_get_value() -> void:
	var operation_node = load(__source).new()
	operation_node.free()
