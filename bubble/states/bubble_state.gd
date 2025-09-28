extends State
class_name BubbleState

var bubble : ABubbleRB

func setup(s_owner, s_machine):
    super(s_owner,s_machine)
    bubble = s_owner as ABubbleRB
