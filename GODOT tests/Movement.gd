extends CharacterBody2D


@export var speed = 200 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

signal casting(spell, direction, location)
@export var firebolt: PackedScene


func _ready():
	screen_size = get_viewport_rect().size
	#Sets character to standstill upon spawn
	$PlayerAvatar.animation = "Standing"


func _process(_delta):
#Two things here: one measures x-velocity, the other y-velocity
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	elif Input.is_action_pressed("move_left"):
		velocity.x = -speed
	else:
		velocity.x = 0
	if Input.is_action_pressed("move_down"):
		velocity.y = speed
	elif Input.is_action_pressed("move_up"):
		velocity.y = -speed
	else:
		velocity.y = 0

#Checks if the Player is moving at all
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$PlayerAvatar.play()
	else:
		$PlayerAvatar.stop()
		$PlayerAvatar.animation = "Standing"
	
	#Checks if the Player is moving along 'x' specifically
	if velocity.x != 0:
		$PlayerAvatar.animation = "Moving"
		$PlayerAvatar.flip_v = false
		$PlayerAvatar.flip_h = velocity.x < 0
	#elif velocity.y != 0:
		#$AnimatedSprite2D.animation = "up"
		#$AnimatedSprite2D.flip_v = velocity.y > 0

	move_and_slide()
	
	if Input.is_action_pressed("cast"):
		fireboltCast()

func fireboltCast():
	if $Cooldown.is_stopped() == true:
		var boltFire = firebolt.instantiate()
		boltFire.position = position
		boltFire.rotation = rotation
		add_sibling(boltFire)
		$Cooldown.set_wait_time(boltFire.cooldown)
		$Cooldown.start()
	


