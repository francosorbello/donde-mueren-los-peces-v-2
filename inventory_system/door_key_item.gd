@tool
extends AnItem
class_name DoorKeyItem

enum KeyType {
    SIMPLE,
    SPECIAL
}

@export var key_type : KeyType