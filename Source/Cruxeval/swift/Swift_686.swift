/// 
func f(d: [String : Int], l: [String]) -> [String : Int] {
    var new_d: [String: Int] = [:]

    for k in l {
        if let value = d[k] {
            new_d[k] = value
        }
    }

    return new_d
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
            
assert(f(d: ["lorem ipsum" : 12, "dolor" : 23], l: ["lorem ipsum", "dolor"]) == ["lorem ipsum" : 12, "dolor" : 23])
