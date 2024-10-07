extends CharacterBody2D

const GRAVITY : int = 4200
const JUMP_SPEED : int = -1800
var jump_pressed: bool = false

func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			jump_pressed = true
			event.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		if not get_parent().game_running:
			$AnimatedSprite2D.play("idle")
		else:
			$RunCol.disabled = false
			if Input.is_action_pressed("ui_accept") or jump_pressed:
				velocity.y = JUMP_SPEED
				jump_pressed = false
				#$JumpSound.play()
			elif Input.is_action_pressed("ui_down"):
				$AnimatedSprite2D.play("duck")
				$RunCol.disabled = true
			else:
				$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("jump")
		
	move_and_slide()
