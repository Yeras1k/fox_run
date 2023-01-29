extends KinematicBody2D

var direction = 1
var Gravity = 200
const Speed = 50
const Floor = Vector2(0, -1)
var n = 0
var is_died = true
var velocity = Vector2()
onready var game_data = SaveFile.game_data
onready var me = self.name

func _ready():
	$anim.play('walk')
		
func hide0():
	game_data.enemy_is_dead.append(me)
	if game_data.enemy_is_dead[-1] == me:
		Gravity = 0
		$CollisionShape2D.disabled = true
		n += 1
		velocity = Vector2.ZERO
		$enemy_boom.play()
		$anim.play('death')
		yield(get_tree().create_timer(1), "timeout")
		visible = false

func hide2():
	Gravity = 0
	$CollisionShape2D.disabled = true
	velocity = Vector2.ZERO
	visible = false
		
func _process(delta):
	if n != 0:
		velocity.x = 0
	else:
		velocity.x = direction * -Speed
		if not $RayCast2D.is_colliding(): 
			direction *= -1
			$RayCast2D.position.x *= -1
			$anim.flip_h = bool(1-direction)
	velocity = move_and_slide(velocity, Floor)
	
