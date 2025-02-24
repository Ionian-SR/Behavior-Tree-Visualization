extends Node
const IF = "if"
const THEN = "then"
const ELSE = "else"
const ELSEIF = "elseif"
const END = "end"
var bt_node_packed: PackedScene = preload("res://src/scenes/BTNode.tscn")
var bt_nodes: Array[BTNode]

func parse(text: String):
	#	Remove tab space
	text = text.replace("\t", " ")
	#	Split text into lines array
	var lines := text.split("\n", false)
	#	Iterate through all lines
	var node_x: int = 800
	var node_y: int = 100
	var is_read_action: int = 0
	for line: String in lines:
		#	Split text within line into tokens with white space
		var tokens := line.split(" ", false) 
		#	Instantiate flag for parser to know when condition is being read
		#	SCUFFED
		var is_read_condition: int = 0
		var condition_line: Array[String]
		var action_line: Array[String]
		
		#	Instantiate BTNode
		var bt_node: BTNode = bt_node_packed.instantiate()
		var bt_label = bt_node.get_node("Label")
		
		#	Iterate through the tokens
		for i in range(tokens.size()):
			var token: String = tokens[i]
			print("Reading:" + token)
			#	Read conditions until met with THEN
			if is_read_condition == 1 and token != THEN:
				condition_line.append(token)
			elif is_read_action == 1 and not token in [IF, ELSEIF, END, ELSE]:
				if not token in [IF, ELSEIF, END, ELSE]:
					action_line.append(token)
					#print("Appending to action_line:", action_line)
				if i == tokens.size() - 1:  
					if !condition_line.is_empty():
						break
					else:
						bt_label.text = " ".join(action_line)
				#if token in [IF, ELSEIF, END, ELSE]:
					#is_read_action = 0  # ✅ Reset only after the full action has been captured
					#print("stopped reading action")
					#print(tokens)
					#bt_label.text = " ".join(action_line)
			elif token == IF:
				#	Turn on flag to let parser know to start reading condition tokens
				is_read_condition = 1
				is_read_action = 0
				condition_line.append(token)
				#bt_label.text = IF
				#print("Detected an IF statement at position:", line.find(IF))
			elif token == THEN:
				#	Turn off flag to let parser know to stop reading condition tokens
				is_read_condition = 0
				#	Turn on flag to start reading action tokens
				is_read_action = 1
				bt_label.text = " ".join(condition_line) + " " + THEN
				condition_line.clear()
			elif token == ELSEIF:
				condition_line.append(token)
				is_read_condition = 1
				is_read_action = 0
				#print("Detected an ELSEIF statement at position:", line.find(ELSEIF))
			elif token == ELSE:
				bt_label.text = ELSE
				is_read_condition = 0
				is_read_action = 1
			elif token == END:
				bt_label.text = END
				is_read_action = 0
				#print("Detected an END statement at position:", line.find(END))
			pass
		node_y += 25
		node_x += 10
		bt_nodes.append(bt_node)
		add_child(bt_node)
		bt_node.set_position(Vector2(node_x, node_y))
		print("Node:" + bt_node.get_node("Label").text)
