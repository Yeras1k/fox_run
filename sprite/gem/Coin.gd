extends Area2D

onready var me = self.name
onready var game_data = SaveFile.game_data

func _physics_process(delta):
	animate()
	
func animate():
	var anim = 'idle'
	$AnimatedSprite.play(anim)

func _on_Coin_body_entered(body):
	if body.has_method("get_coin"):
		game_data.is_coin.append(me)
		if game_data.is_coin[-1] == me:
			body.get_coin()
			queue_free()
	
