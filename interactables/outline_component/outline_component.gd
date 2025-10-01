extends Node
class_name OutlineComponent

@export var outline_shader : Shader
@export var sprite : Sprite2D
@export_group("Overrides")
@export var override_color_when_disabled : bool
@export var override_color_value = Color.WHITE

var material : ShaderMaterial

func _ready() -> void:
    material = ShaderMaterial.new()
    material.shader = outline_shader
    sprite.material = material
    disable_outline()

func enable_outline(color : Color = Color.WHITE):
    material.set_shader_parameter("width",1.0)
    material.set_shader_parameter("color",color)
    if override_color_when_disabled:
        sprite.modulate = Color.WHITE

func disable_outline():
    if override_color_when_disabled:
        sprite.modulate = override_color_value
    material.set_shader_parameter("width",0.0)