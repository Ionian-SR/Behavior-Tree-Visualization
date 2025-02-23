extends Node
const IF = "if"
const THEN = "then"
const ELSE = "else"
const ELSEIF = "elseif"
const END = "end"

func parse(text: String):
	#	Remove tab space
	text = text.replace("\t", " ")
	#	Split text into lines array
	var lines := text.split("\n", false)
	#	Iterate through all lines
	for line: String in lines:
		#	Split text within line into tokens with white space
		var tokens := line.split(" ", false) 
		#	Iterate through the tokens
		for token: String in tokens:
			if token == IF:
				
				print("Detected an 'if' statement at position:", line.find(IF))
			elif token == THEN:
				print("Detected an THEN' statement at position:", line.find(THEN))
			elif token == ELSEIF:
				print("Detected an ELSEIF' statement at position:", line.find(ELSEIF))
			pass
