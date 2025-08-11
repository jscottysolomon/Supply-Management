class_name Road
extends MapElement

var trucks = Array()
@onready var line_r = $Line2D
var vertical:bool
var length: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var v1 = line_r.get_point_position(0)
	var v2 = line_r.get_point_position(1)
	vertical = (v1.x == v2.x)
	if vertical:
		length = abs(v1.y - v2.y)
	else:
		length = abs(v1.x - v2.x)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_trucks():
	return trucks


func get_length():
	return length

func add_truck(truck:Truck):
	trucks.append(truck)


func remove_truck(truck:Truck):
	trucks.erase(truck)
