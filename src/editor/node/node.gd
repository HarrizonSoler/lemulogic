class_name RoutineNode extends GraphNodeFacade

@export var type: RoutineNodeType
@export var slots: Array[RoutineNodeSlot]
@export var id: int
@export var keyword: StringName

func _ready() -> void:
	set_routine_type(type)
	set_routine_slots(slots)
	set_node_title()
	super._ready()

func set_node_title() -> void:
	title = type.title
	if selectable and draggable: title = "(" + str(id) + ") " + title

func set_id(_id: int) -> void:
	id = _id

func execute(_context: RoutineContext, _loop_node_id: StringName = "") -> Dictionary:
	printerr("RoutineNode: execute method not implemented in node ", name)
	return {}

func get_value(_context: RoutineContext):
	printerr("RoutineNode: get_value method not implemented in node ", name)
	
func get_input_port_routine_slot(port: int) -> RoutineNodeSlot:
	return get_routine_slot(get_input_port_slot(port))

func get_output_port_routine_slot(port: int) -> RoutineNodeSlot:
	return get_routine_slot(get_output_port_slot(port))

func get_routine_slot(slot_id: int) -> RoutineNodeSlot:
	var search := slots.filter(func (slot: RoutineNodeSlot):
		return slot.id == slot_id
	)
	
	if search.size() != 1:
		printerr("RoutineNode: Node ", name, " slot not found for id ", slot_id)
	
	return search[0]
