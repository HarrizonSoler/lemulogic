class_name RoutineNodeSlot extends Resource

const RETURN_TYPE_COLOR = {
	Type.VALUE: Color("ffffff"),
	Type.ACTION: Color("98b3d9")
}

enum Type { VALUE, ACTION }
enum Capacity { SINGLE, MULTIPLE }

@export var id: int
@export var name: StringName
@export var type: Type
@export var capacity: Capacity
@export var type_restriction: RoutineNodeType
@export var node_restriction_keyword: StringName
@export var is_optional: bool
