extends Node2D

var pheromones = []

func add_pheromone(pos):

	pheromones.append({
		"position": pos,
		"strength": 1.0
	})

func _process(delta):

	for p in pheromones:
		p.strength -= delta * 0.1

	pheromones = pheromones.filter(func(p): return p.strength > 0)
