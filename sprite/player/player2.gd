extends KinematicBody2D


var n = 0
var run_speed = 0
var jump_speed = 0
var gravity = 0
var coins = 0
var velocity = Vector2()
onready var game_data = SaveFile.game_data

func _ready():
	position.x = game_data.position[1][0]
	position.y = game_data.position[1][1]
	coins = game_data.coins
	get_tree().call_group("texting", "change", coins)

func enable():
	run_speed = 200
	jump_speed = -140
	gravity = 260
	self.visible = game_data.is_two
	
func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_up')

	if is_on_floor() and jump:
		$player_jump.play()
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
		SaveFile.save_data()
	if left:
		velocity.x -= run_speed
		SaveFile.save_data()

	
func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1), false, 4, 0.785, false)
	animate()
	for index in get_slide_count():
		$die_r.force_raycast_update()
		$die_l.force_raycast_update()
		var collision = get_slide_collision(index)
		if collision.collider.name.begins_with("enemy") and not $ForEnemy.is_colliding():
			$player_die.play()
			n = 1
			position.x = game_data.position[1][0]
			position.y = game_data.position[1][1]
			SaveFile.save_data()
			var timer = Timer.new()
			timer.connect("timeout",self,"change_stopper",[0]) 
			timer.wait_time = 1
			timer.one_shot = true
			add_child(timer)
			timer.start()
		if $die_r.is_colliding():
			var collider1 = $die_r.get_collider()
			if collider1.is_in_group("enemies"):
				$player_die.play()
				n = 1
				position.x = game_data.position[1][0]
				position.y = game_data.position[1][1]
				SaveFile.save_data()
				var timer = Timer.new()
				timer.connect("timeout",self,"change_stopper",[0]) 
				timer.wait_time = 1
				timer.one_shot = true
				add_child(timer)
				timer.start()
		if $die_l.is_colliding():
			var collider2 = $die_l.get_collider()
			if collider2.is_in_group("enemies"):
				$player_die.play()
				n = 1
				position.x = game_data.position[1][0]
				position.y = game_data.position[1][1]
				SaveFile.save_data()
				var timer = Timer.new()
				timer.connect("timeout",self,"change_stopper",[0]) 
				timer.wait_time = 1
				timer.one_shot = true
				add_child(timer)
				timer.start()
	pass
	$ForEnemy.force_raycast_update()
	if $ForEnemy.is_colliding():
		var collider = $ForEnemy.get_collider()
		if collider.is_in_group("enemies"):
			var enemy_name = "%" + collider.get_name()
			velocity.y = -100
			get_node(enemy_name).hide0()
			game_data.coins += 5
			SaveFile.save_data()
			coins = game_data.coins
			get_tree().call_group("texting", "change", coins)

func get_coin():
	game_data.coins += 1
	SaveFile.save_data()
	coins = game_data.coins
	$gem_pickup.play()
	get_tree().call_group("texting", "change", coins)
	if coins == 18:
		get_tree().change_scene("res://scenes/Second.tscn")
	
func change_stopper(b):
	n = b
	
func animate():
	var anim = 'idle'
	if n == 1:
		anim = 'death'
	else:
		if velocity.y < 0 and not $RayCast2D.is_colliding():
			anim = 'jump'
		elif velocity.y > 0 and not $RayCast2D.is_colliding():
			anim = 'fall'
		else:
			if velocity.x != 0:
				anim = 'run'
				if velocity.x > 0:
					$Sprite.flip_h = false
				else:
					$Sprite.flip_h = true
	if $Sprite.animation != anim:
		$Sprite.play(anim)
