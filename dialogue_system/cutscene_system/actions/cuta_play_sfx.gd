extends CutsceneAction

@export var sfx : AudioStream

func do_action():
    assert(sfx != null, "(%s) No sfx to play"%name)

    var stream_player = AudioStreamPlayer.new()
    stream_player.bus = "SFX"
    stream_player.stream = sfx
    add_child(stream_player)
    
    stream_player.play()
    