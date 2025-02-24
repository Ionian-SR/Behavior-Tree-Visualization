class_name BTNode
extends Control
#extends RefCounted

enum NodeType { IF, ELSEIF, ELSE, ACTION }

var type: NodeType
var condition: String = ""  # Condition like "distanceEnemy > 7"
var action: String = ""  # Action like "act[1] = 100"
var left: BTNode = null  # True branch
var right: BTNode = null  # False branch (elseif/else)
