@tool
extends EditorPlugin

const SOUND : AudioStreamWAV = preload("res://addons/puppy-bark/puppy-bark.wav")
const MAX_PLAYERS : int = 8
var audio_players : Array[AudioStreamPlayer] = []

func _enter_tree() -> void:
	for i in MAX_PLAYERS:
		var ap = AudioStreamPlayer.new()
		ap.stream = SOUND
		ap.volume_linear = 0.15
		get_tree().root.add_child(ap)
		audio_players.append(ap)
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_pressed():
			var available : Array[AudioStreamPlayer] = audio_players.filter(
				func(ap: AudioStreamPlayer): 
					return !ap.playing
			)
			
			if available.size() > 0:
				var ap = available.front()
				ap.pitch_scale = randf_range(1, 1.2)
				ap.play()
			

func _exit_tree() -> void:
	for ap in audio_players:
		ap.queue_free()
