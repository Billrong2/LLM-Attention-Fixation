/// 
func f(obj: [String : Int]) -> [String : Int] {
    var updatedObj = obj
    for (key, value) in updatedObj {
        if value >= 0 {
            updatedObj[key] = -value
        }
    }
    return updatedObj
}


func ==(left: [(Int, Int)], right: [(Int, Int)]) -> Bool {
    if left.count != right.count {
        return false
    }
    for (l, r) in zip(left, right) {
        if l != r {
            return false
        }
    }
    return true
}
            
assert(f(obj: ["R" : 0, "T" : 3, "F" : -6, "K" : 0]) == ["R" : 0, "T" : -3, "F" : -6, "K" : 0])
