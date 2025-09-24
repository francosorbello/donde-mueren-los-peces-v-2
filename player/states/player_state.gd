extends State
class_name PlayerState

var player : APlayer

func setup(s_owner, s_machine):
    super(s_owner,s_machine)
    player = s_owner as APlayer
