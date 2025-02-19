extends CanvasLayer

var time_left = 300 # seconds = 5 min
func _ready() -> void:
	$TimerCountdown.start()
	update_time_label()
	
func update_time_label() -> void:
	var minutes: int = time_left / 60
	var seconds: int = time_left % 60
	$Timer.text = "Time\n%02d:%02d" % [minutes, seconds] 

func _on_timer_countdown_timeout() -> void:
	if time_left > 0:
		time_left -= 1 
		update_time_label()  
	else:
		$TimerCountdown.stop()
		show_game_over()
		
func show_game_over():
	$GameOver.visible = true
	$TryAgainButton.visible = true

func _on_try_again_button_pressed() -> void:
	Global.coins = 0
	get_tree().change_scene_to_file("res://main.tscn")
