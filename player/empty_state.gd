extends PlayerState
## empty state, intended to be used in situations where we dont want player movement enabled
## ej: when opening ui

func enter():
    player.play_anim("idle")
    player.velocity = Vector2.ZERO