extends Node
var bt_node_packed: PackedScene = preload("res://src/scenes/BTNode.tscn")
var bt_nodes: Array[BTNode]
@onready var button: Button = $Button
@onready var text_edit: TextEdit = $TextEdit
@onready var rich_text_label: RichTextLabel = $RichTextLabel

func _ready():
	pass

func _on_button_pressed() -> void:
	var bt_node: BTNode = bt_node_packed.instantiate()
	bt_nodes.append(bt_node)
	add_child(bt_node)
	Parser.parse(text_edit.text)
	#print("test")
	pass

func _on_text_edit_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):	
		rich_text_label.text = text_edit.text
		#rint("test")
	pass # Replace with function body.
