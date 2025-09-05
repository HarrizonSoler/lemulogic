# GdUnit generated TestSuite
class_name BaseStringTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://src/editor/node/prefab/base/base_string.gd'

func test_get_value() -> void:
	var expected_str := "Hello World!"
	var routine_mock := Routine.new()
	var context_mock := RoutineContext.new(routine_mock, [])
	var text_mock: TextEdit = mock(TextEdit)
	text_mock.text = expected_str
	
	var string_node = load(__source).new()
	string_node.text_input = text_mock
	var node_text: String = string_node.get_value(context_mock)
	
	assert_str(node_text).is_equal(expected_str)
	print(node_text)
	
	string_node.free()
	context_mock.free()
