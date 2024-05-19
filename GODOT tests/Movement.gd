extends CharacterBody2D

@export var mousePos = Vector2() ##Should get the position of the mouse. Does not work, for whatever reason.
@export var speed = 200 # How fast the player will move (pixels/sec).
@export var hitPoints = 0 ##Nuværende hitpoints
@export var cooldown = 0.2 ##Cooldown mellem projektiler. Ideelt skulle denne gerne flyttes til 
##våben senere, men vi har tilpasset os tidsbegrænsningerne. 
var maxHitPoints = 20 ##Maksimale mængde af hitpoints. 

signal death

signal damageTaken(damage) ##Signal, der kan registrere damage-output fra eksterne kilder

var screen_size # Size of the game window.

signal casting(spell, direction, location)
@export var firebolt: PackedScene

var projectile = load("res://Projectiles/firebolt.tscn")

func _enter_tree():
	set_multiplayer_authority(name.to_int())
	if is_multiplayer_authority():
		$Camera2D.enabled = true
	hitPoints = maxHitPoints

func _ready():
	screen_size = get_viewport_rect().size
	#Sets character to standstill upon spawning
	$PlayerAvatar.animation = "Standing"


func _process(_delta):
	if is_multiplayer_authority():
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
	
		if Input.is_action_pressed("cast") && $Cooldown.is_stopped() == true:
			$Cooldown.wait_time = cooldown
			$Cooldown.start()
			var startPos = Vector2()
			#var targetPos = Vector2()
			startPos = position
			mousePos = get_global_mouse_position()
			get_parent()._spawn_projectile.rpc(startPos, mousePos)


func damage(amount):
	hitPoints -= amount
	if hitPoints <= 0:
		queue_free()

func _on_damage_taken(damage):
	hitPoints -= damage
	if hitPoints <= 0:
		get_parent().find_child("Menu").visible = true
		queue_free()

