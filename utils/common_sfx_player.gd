extends Node

@export var sounds : Dictionary[String, AudioStream]

var _audio_players : Dictionary[String, AudioStreamPlayer]

func _ready():
    create_audio_players()

func create_audio_players():
    for sound_name in sounds.keys():
        var _audio_player = $Template.duplicate() as AudioStreamPlayer
        add_child(_audio_player)
        _audio_player.stream = sounds[sound_name]
        _audio_players.set(sound_name,_audio_player)

func play_sound(sound_name, randomize_pitch : bool = true):
    if _audio_players.has(sound_name) and not _audio_players[sound_name].playing:
        if randomize_pitch:
            _audio_players[sound_name].pitch_scale = randf_range(0.7,1.3)
        _audio_players[sound_name].play()