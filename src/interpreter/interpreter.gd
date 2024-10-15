class_name RoutineInterpreter extends Node

enum TickReturn {
	ROUTINE_ENDED,
	ROUTINE_CONTINUE
}

const START_NODE_ID: StringName = "BaseStart"

var context: RoutineContext

var next_node_id: StringName = START_NODE_ID
var loop_node_id: StringName = ""

func _init(_routine: Routine, _variables: Array[StringName]) -> void:
	context = RoutineContext.new(_routine, _variables)

#func _ready() -> void:
	#context = RoutineContext.new(RoutineSingleton.get_routine(), RoutineSingleton.get_variables())
	#
	#var is_routine_finished := false
	#
	#while not is_routine_finished:
		#if tick() == TickReturn.ROUTINE_ENDED: is_routine_finished = true

func tick() -> TickReturn:
	var result = context.execute_node(next_node_id, loop_node_id)
	
	match result.status:
		RoutineContext.ExecutionResult.ROUTINE_END_REACHED:
			return TickReturn.ROUTINE_ENDED
		RoutineContext.ExecutionResult.LOOP_START_REACHED:
			next_node_id = result.loop_node
			loop_node_id = ""
			return TickReturn.ROUTINE_CONTINUE
		RoutineContext.ExecutionResult.NODE_END_REACHED:
			printerr("Interpreter: Invalid tick status return END_NODE_REACHED on node_id: ", next_node_id)
			return TickReturn.ROUTINE_ENDED
		_:
			printerr("Interpreter: Invalid tick return ", result, " on node_id: ", next_node_id)
			return TickReturn.ROUTINE_ENDED
