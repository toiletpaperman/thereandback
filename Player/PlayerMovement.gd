extends KinematicBody2D

const DASHFORCE = 600
const MOVESPEED = 30
const FRICTION = 0.8
const DASHCOOLDOWN = 2

var motion = Vector2()  # The player's movement vector.
var dir = Vector2() #input direction
var state
var can_dash = true

func _ready():
	$DashCoolDown.wait_time = DASHCOOLDOWN

func _process(delta):
	manage_dir()
	add_forces()
	move()
	dash()

func manage_dir():
	dir = Vector2.ZERO
	if Input.is_action_pressed("Right"):
		dir.x += 1
	if Input.is_action_pressed("Left"):
		dir.x -= 1
	if Input.is_action_pressed("Down"):
		dir.y += 1
	if Input.is_action_pressed("Up"):
		dir.y -= 1
	dir = dir.normalized()

func move():
	motion += dir * MOVESPEED
	move_and_slide(motion)

func add_forces():
	motion *= FRICTION #friction

func dash():
	if Input.is_action_just_pressed("Dash") and can_dash:
		motion = Vector2.ZERO
		motion += dir * DASHFORCE
		can_dash = false
		$DashCoolDown.start()


func _on_DashCoolDown_timeout():
	can_dash = true
