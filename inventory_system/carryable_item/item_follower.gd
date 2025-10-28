extends Node2D

var item : AnItem

func setup(an_item : AnItem,target : Node2D):
    item = an_item
    $Sprite2D.texture = item.world_icon
    $TargetFollowComponent.target = target