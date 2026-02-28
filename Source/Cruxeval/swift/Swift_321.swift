/// 
func f(update: [String : Int], starting: [String : Int]) -> [String : Int] {
    var d = starting
    for (key, value) in update {
        if let existingValue = d[key] {
            d[key] = existingValue + value
        } else {
            d[key] = value
        }
    }
    return d
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
            
assert(f(update: [:] as [String : Int], starting: ["desciduous" : 2]) == ["desciduous" : 2])
