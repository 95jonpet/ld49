extends Node

var current_song: int = 0
onready var music_player: AudioStreamPlayer = get_node("MusicPlayer")
onready var songs: Array = [
	preload("res://music/slow1.wav"),
	preload("res://music/slow2.wav")
]


func play_music():
	if music_player.playing:
		return
	
	music_player.stream = songs[current_song] as AudioStream
	music_player.play()


func play_next_song():
	current_song = wrapi(current_song + 1, 0, len(songs))
	music_player.stop()
	play_music()
	


func _on_MusicPlayer_finished() -> void:
	play_next_song()
