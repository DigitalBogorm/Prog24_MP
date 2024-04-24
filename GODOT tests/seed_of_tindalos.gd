extends CharacterBody2D

@export_category("Stats")
@export var SPEED = 300.0


var targetLocation: Vector2
var pathing = true


func _ready():
	#"Avatar" er navnet på den gruppe spilleren er i.
	targetLocation = get_tree().get_first_node_in_group("Avatar").position
	$NavigationAgent2D.target_position = targetLocation
	

func _physics_process(delta):
	velocity = position.direction_to($NavigationAgent2D.get_next_path_position()) * SPEED
	
	if pathing == true:
		move_and_slide()




func _on_navigation_agent_2d_target_reached():
	pathing = false
