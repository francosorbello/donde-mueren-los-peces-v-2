extends PersistentEventConditional

func evaluate() -> bool:
    var ev := get_event()
    return ev.value == 1.0
