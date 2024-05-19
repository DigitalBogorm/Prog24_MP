extends Area2D
@export var speed = 2
@export var cooldown = 0.1
@export var dmg = 2
@export var knockBack = 0.1
var active = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Flame.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x(speed)



func _on_body_entered(body):
	if active == true:
		if body.is_in_group('Avatar'):
			body.damage(dmg)
		queue_free()


func _on_body_exited(body):
	active = true
