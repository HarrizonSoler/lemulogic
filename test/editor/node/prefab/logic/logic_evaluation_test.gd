# GdUnit generated TestSuite
class_name LogicEvaluationTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://src/editor/node/prefab/logic/logic_evaluation.gd'


func test_get_value() -> void:
	var evaluation_node = load(__source).new()
	evaluation_node.free()
