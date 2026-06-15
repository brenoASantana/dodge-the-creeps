extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Prepare-se")
	get_tree().call_group("mobs", "queue_free")


func _on_mob_timer_timeout() -> void:
	# Apaga a mensagem quando o primero mob surgir
	$HUD.show_message("")
	
	# Cria uma instancia da Cena Mob
	var mob = mob_scene.instantiate()
	
	# Escolhe uma localização aleatoria no Path2D
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	# Define a posição do para a localização aleatoria
	mob.position = mob_spawn_location.position
	
	# Define a direção perpendicular do mob para a direção do caminho
	var direction = mob_spawn_location.rotation + PI / 2
	
	# Adiciona alguma aleatoriedade para a direção
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Escolhe a velocidade para o mob
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Sumona o mob ao adiciona-lo na cena Main
	add_child(mob)
	


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
