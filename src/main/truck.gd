class_name Truck
extends MapElement

const MARGIN = 35

var capacity = 0
var speed = 2
var contents
var road:Road
var destination:Factory
var pathway = Array()
var items = Array()

var route_len:int = -1
var route:Array[MapElement] = []
var dest_vector:Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move()
	pass


func get_distance(v1:Vector2, v2:Vector2):
	return sqrt(pow(v2.x - v1.x,2) + pow(v2.y - v1.y,2))

func move():
	if route.size() <= 0:
		return
	dest_vector = route[0].get_position()
	var move_x:bool = (abs(dest_vector.x - self.position.x) >
			abs(dest_vector.y - self.position.y))
	if move_x:
		if dest_vector.x < (self.position.x):
			self.position.x -= speed
		elif dest_vector.x > (self.position.x):
			self.position.x += speed
	else:
		if dest_vector.y < (self.position.y):
			self.position.y -= speed
		elif dest_vector.y > (self.position.y):
			self.position.y += speed
	if get_distance(self.position,dest_vector) <= MARGIN:
		route.remove_at(0)


func set_road(r:Road):
	road = r


func get_road():
	return road


func set_destination(dest:Factory):
	destination = dest


func find_route(dest:MapElement):
	destination = dest
	route_len = -1
	find_route_helper(get_road(),[],0)
	print(route_len, ": ",route)
	route.remove_at(0)
	pass


func find_route_helper(current:MapElement,list:Array[MapElement],len:int):
	if current is Truck:
		return
	if current == destination:
		list.append(current)
		if len < route_len or route_len <= 0:
			route = list
			route_len = len
		return
	if list.has(current):
		return
	else:
		list.append(current)
		if current is Road:
			len += current.get_length()
		var connections = current.get_connections()
		for conn in connections:
			find_route_helper(conn,list.duplicate(),len)

func get_destination():
	return destination
