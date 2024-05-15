extends CharacterBody2D


@export var speed = 200 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

signal casting(spell, direction, location)
@export var firebolt: PackedScene

var projectile = load("res://Projectiles/firebolt.tscn")

func _enter_tree():
	set_multiplayer_authority(name.to_int())
	if is_multiplayer_authority():
		$Camera2D.enabled = true
	#$MultiplayerSpawner.set_spawn_path(self.get_parent().get_path())

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
	
		if Input.is_action_pressed("cast"):
			var startPos = Vector2()
			var targetPos = Vector2()
			startPos = position
			targetPos = get_local_mouse_position()
			#$MultiplayerSpawner.add_spawnable_scene('shot')
			#call_deferred("add_child",shot)
			get_parent()._spawn_projectile.rpc(startPos, targetPos)
			
		
		
		




