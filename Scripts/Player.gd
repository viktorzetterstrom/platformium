extends KinematicBody2D

# Constants
const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_SPEED = 200
const JUMP_HEIGHT = -1000
const ACCELERATION = 50

# Body motion
var motion = Vector2()

# Physics process for moving object
func _physics_process(delta):
  motion.y += GRAVITY
  var friction = false

  # Move, if both or none are pressed, stand still.
  if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
    motion.x = 0
  elif Input.is_action_pressed("ui_right"):
    # Set speed
    motion.x = min(motion.x + ACCELERATION, MAX_SPEED)

    # Animate
    $Sprite.flip_h = false
    $Sprite.play("run")
  elif Input.is_action_pressed("ui_left"):
    # Set speed
    motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)

    # Animate
    $Sprite.flip_h = true
    $Sprite.play("run")
  else:
    friction = true
    $Sprite.play("idle")


  if is_on_floor():
    if Input.is_action_just_pressed("ui_up"):
      motion.y = JUMP_HEIGHT
    if friction:
      motion.x = lerp(motion.x, 0, 0.2)
  else:
    if motion.y < 0:
      $Sprite.play("jump")
    else:
      $Sprite.play("fall")
    if friction:
      motion.x = lerp(motion.x, 0, 0.05)

  # Use motion to move.
  motion = move_and_slide(motion, UP)
  pass