extends Object
class_name FreyaMath

## Functions extracted from https://youtu.be/LSNQuFEDOyQ?si=DMxhBLTBbaGi29ck
#region lerp

static func move_towards_linear_float(a : float, b : float, speed : float, delta : float):
    var v = b - a
    var step_dist = speed * delta
    if step_dist >= abs(v):
        return b 
    
    return a + sign(v) * step_dist

static func move_towards_linear_vector_2(a : Vector2, b : Vector2, speed : float, delta : float) -> Vector2:
    var v = b - a
    var step_dist = speed * delta
    if step_dist >= v.length():
        return b 
    
    return a + v.normalized() * step_dist

static func move_towards_linear_vector_3(a : Vector3, b : Vector3, speed : float, delta : float) -> Vector3:
    var v = b - a
    var step_dist = speed * delta
    if step_dist >= v.length():
        return b 
    
    return a + v.normalized() * step_dist


## Linear interpolation using decay [br]
## a = exp_decay_float(a,b,decay,delta)[br]
## It is recomended to use decay values between 1 and 25 (from slow to fast)
static func lerp_exp_decay(a : Variant, b: Variant, decay : float, delta : float) -> Variant:
    return b+(a-b) * exp(-decay * delta)

## Linear interpolation using decay [br]
## a = exp_decay_float(a,b,decay,delta)[br]
## It is recomended to use decay values between 1 and 25 (from slow to fast)
static func exp_decay_float(a : float ,b : float , decay : float , delta : float) -> float:
    return b+(a-b) * exp(-decay * delta)

## Linear interpolation using decay [br]
## a = exp_decay_float(a,b,decay,delta)[br]
## It is recomended to use decay values between 1 and 25 (from slow to fast)
static func exp_decay_vector_2(a : Vector2 ,b : Vector2 , decay : float , delta : float) -> Vector2:
    return b+(a-b) * exp(-decay * delta)

## Linear interpolation using decay [br]
## a = exp_decay_float(a,b,decay,delta)[br]
## It is recomended to use decay values between 1 and 25 (from slow to fast)
static func exp_decay_vector_3(a : Vector3 ,b : Vector3 , decay : float , delta : float) -> Vector3:
    return b+(a-b) * exp(-decay * delta)

#endregion 