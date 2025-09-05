# GdUnit generated TestSuite
class_name BasePrintTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://src/editor/node/prefab/base/base_print.gd'


func test_execute() -> void:
	var print_node = load(__source).new()
	print_node.free()
