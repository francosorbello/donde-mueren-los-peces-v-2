extends Area2D
class_name FloorDetector

enum DetectionStatus {
    ON_FLOOR,
    ON_PLATFORM,
    FALLING
}

signal floor_status_changed(new_status : DetectionStatus)

var current_status : DetectionStatus = DetectionStatus.ON_FLOOR:
    set(value):
        if value != current_status:
            current_status = value
            floor_status_changed.emit(value)
            # print("Floor detector says player is %s"%DetectionStatus.find_key(value))

func _physics_process(_delta):
    var new_status : DetectionStatus = DetectionStatus.ON_FLOOR
    
    var areas = get_overlapping_areas()
    for area in areas:
        if area is PlatformArea:
            new_status = DetectionStatus.ON_PLATFORM
            break
        elif area.get_parent() and area.get_parent() is DeathZone:
            new_status = DetectionStatus.FALLING

    current_status = new_status