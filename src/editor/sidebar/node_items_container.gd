class_name NodeItemsContainer extends PanelContainer

const node_item_scene: PackedScene = preload("res://ui/editor/node/components/node_sidebar_item.tscn")

@export var title_label: Label
@export var items_container: VBoxContainer

func set_title(title: String) -> void:
	title_label.text = title

func set_items(items: Dictionary) -> void:
	for title in items.keys():
		var item := node_item_scene.instantiate()
		item.set_title(title)
		item.set_node(items[title].instantiate())
		items_container.add_child(item)
