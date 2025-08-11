extends Node2D

const COMPARE_VAL:int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_elements()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func get_distance(v1:Vector2, v2:Vector2):
	return sqrt(pow(v2.x - v1.x,2) + pow(v2.y - v1.y,2))
	
	
func find_shortest_path(truck:Truck, factory:Factory):
	#truck.route(truck.get_road(),factory,[])
	truck.find_route(factory)
	pass

func connect_elements():
	var arr = get_tree().get_nodes_in_group("Traffic")
	var factory_r = get_tree().get_nodes_in_group("Factory")
	var road_r = get_tree().get_nodes_in_group("Road")
	var truck_r = get_tree().get_nodes_in_group("Truck")
	var inn_r = get_tree().get_nodes_in_group("Intersection")
	var curr = 0
	
	for road in road_r:
		var line:Line2D = road.get_child(1)
		if line == null:
			continue 
		var v1 = line.to_global(line.get_point_position(0))
		var v2 = line.to_global(line.get_point_position(1))
		var comparisonV:Vector2
		
		var vert:bool = (v1.x == v2.x)

		for inn in inn_r:
			comparisonV = inn.get_position()
			if (get_distance(v1,comparisonV) < 100 or get_distance(v2,comparisonV) < 100):
				road.add_connection(inn)
				inn.add_connection(road)
		
		for factory in factory_r:
			comparisonV = factory.get_position()
			var closest:Vector2
			var add:bool = false
			if not vert:
				if ((comparisonV.x <= v1.x and comparisonV.x>= v2.x) or 
						(comparisonV.x >= v1.x and comparisonV.x <= v2.x)):
					closest.y = v1.y
					closest.x = comparisonV.x
					add = get_distance(closest,comparisonV) < 150
			elif ((comparisonV.y <= v1.y and comparisonV.y>= v1.y) or 
						(comparisonV.y >= v1.y and comparisonV.y <= v1.y)):
					closest = v1
					closest.y = comparisonV.y
					add = get_distance(closest,comparisonV) < 150
			if add:
				road.add_connection(factory)
				factory.add_connection(road)
				
		for truck in truck_r:
			comparisonV = truck.get_position()
			var closest:Vector2
			var add:bool = false
			if not vert:
				if ((comparisonV.x <= v1.x and comparisonV.x>= v2.x) or 
						(comparisonV.x >= v1.x and comparisonV.x <= v2.x)):
					closest.y = v1.y
					closest.x = comparisonV.x
					add = get_distance(closest,comparisonV) < 50
			elif ((comparisonV.y <= v1.y and comparisonV.y>= v1.y) or 
						(comparisonV.y >= v1.y and comparisonV.y <= v1.y)):
					closest = v1
					closest.y = comparisonV.y
					add = get_distance(closest,comparisonV) < 50
			if add:
				road.add_connection(truck)
				truck.add_connection(road)
				truck.set_road(road)
			pass
	
	for r in road_r:
		r.print_connections()
	for inn in inn_r:
		inn.print_connections()
	for fac in factory_r:
		fac.print_connections()
	for truck in truck_r:
		truck.print_connections()
		
	find_shortest_path(truck_r[0],factory_r[1])
					
