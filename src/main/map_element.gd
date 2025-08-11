class_name MapElement 
extends Node2D

var arr = Array()
var pos: Vector2
var line: Line2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func connects(value):
	return arr.has(value)
	
	
func get_connections():
	return arr
	
func print_connections():
	var out:String = self.name + "->\t"
	for el in arr:
		out += el.name + ", "
		
	print(out)

	
func add_connection(value):
	if not arr.has(value):
		arr.append(value)


func remove_connection(value):
	if arr.has(value):
		arr.erase(value)
		return true
	return false
