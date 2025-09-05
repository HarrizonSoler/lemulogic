# GdUnit generated TestSuite
class_name MathNumberTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://src/editor/node/prefab/math/math_number.gd'


func test_get_value() -> void:
	var integer_node = load(__source).new()
	integer_node.free()
