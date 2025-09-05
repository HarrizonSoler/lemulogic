# GdUnit generated TestSuite
class_name BaseStartTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://src/editor/node/prefab/base/base_start.gd'

func test_execute() -> void:
	var routine_mock := Routine.new()
	var context_mock := RoutineContext.new(routine_mock, [])
	
	var start_node = load(__source).new()
	start_node.execute(context_mock)
	
	start_node.free()
	context_mock.free()
