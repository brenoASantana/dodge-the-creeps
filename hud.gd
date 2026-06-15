extends CanvasLayer

# Notifica o nó 'Main' que o botão foi pressionado
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	# Espera até o MessageTimer terminar a contagem
	await $MessageTimer.timeout
	
	$MessageLabel.text = "Dodge the Creeps!"
	$MessageLabel.show()
	# Cria um timer unitário e espera terminar
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)
	
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
	
func _on_message_timer_timeout():
	$Message.hide()
	
	
	
