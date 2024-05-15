extends Area2D
@export var speed = 2
@export var cooldown = 0.1
@export var dmg = 2
@export var knockBack = 0.1


# Called when the node enters the scene tree for the first time.
func _ready():
	$Flame.play()
	look_at(get_global_mouse_position())
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x(speed)


func _on_body_entered(body):
	queue_free()
