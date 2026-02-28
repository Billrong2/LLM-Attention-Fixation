/// 
func f(commands: [[String : Int]]) -> [String : Int] {
    var d: [String: Int] = [:]
    for c in commands {
        for (key, value) in c {
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
            
assert(f(commands: [["brown" : 2], ["blue" : 5], ["bright" : 4]]) == ["brown" : 2, "blue" : 5, "bright" : 4])
