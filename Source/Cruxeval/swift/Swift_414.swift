/// 
func f(d: [String : [String]]) -> [String : [String]] {
    var dCopy = d
    for (key, var value) in dCopy {
        for i in 0..<value.count {
            value[i] = value[i].uppercased()
        }
        dCopy[key] = value
    }
    return dCopy
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
            
assert(f(d: ["X" : ["x", "y"]]) == ["X" : ["X", "Y"]])
