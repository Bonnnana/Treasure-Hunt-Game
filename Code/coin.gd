extends Area3D

const ROTATION_SPEED = 2


func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	rotate_y(deg_to_rad(ROTATION_SPEED))
	
func _on_body_entered(body: Node3D) -> void:
	Global.coins += 1
	update_coins_label()
	
	if Global.coins >= 10:
		show_message()
	queue_free()
	
func update_coins_label():
	var canvas = get_node("/root/Main/CanvasLayer")
	var coins_label = canvas.get_node("CoinsCollected")
	coins_label.text = "Collected\n" + str(Global.coins)
	
func show_message():
	var canvas = get_node("/root/Main/CanvasLayer")
	var time = canvas.get_node("TimerCountdown")
	time.stop()
	
	var you_win_label = canvas.get_node("YouWin")
	you_win_label.visible = true
	
