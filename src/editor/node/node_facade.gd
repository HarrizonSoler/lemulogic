class_name GraphNodeFacade extends GraphNode

@export var allow_close: bool = true

const CLOSE_BUTTON_SCENE: PackedScene = preload("res://ui/editor/node/components/node_button_close.tscn")

func _ready() -> void:
	if get_parent().is_class("GraphEdit") and allow_close:
		var close_button := CLOSE_BUTTON_SCENE.instantiate()
		close_button.pressed.connect(_on_close_button_pressed)
		get_titlebar_hbox().add_child(close_button)

func _on_close_button_pressed() -> void:
	get_parent().delete_node(self)

func set_routine_slots(slots: Array[RoutineNodeSlot]) -> void:
	for slot in slots:
		if is_slot_enabled_left(slot.id):
			set_slot_type_left(slot.id, slot.type)
			set_slot_color_left(slot.id, get_slot_color(slot))
		elif is_slot_enabled_right(slot.id):
			set_slot_type_right(slot.id, slot.type)
			set_slot_color_right(slot.id, get_slot_color(slot))
		else:
			printerr("GraphNodeFacade: Node \"", name, "\" slot ", slot.id, " is not enabled")

func get_slot_color(slot: RoutineNodeSlot) -> Color:
	if slot.type_restriction:
		return slot.type_restriction.color.lightened(0.2)
	
	return RoutineNodeSlot.RETURN_TYPE_COLOR[slot.type]

func set_routine_type(type: RoutineNodeType) -> void:
	if type == null:
		printerr("GraphNodeFacade: RoutineNodeType not set for node ", name)
		return
		
	title = type.title
	_set_styles(type.get_styles())

func _set_styles(styles: Dictionary) -> void:
	for style in styles.keys():
		add_theme_stylebox_override(style, styles[style])
