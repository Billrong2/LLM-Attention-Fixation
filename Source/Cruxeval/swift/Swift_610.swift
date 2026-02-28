func f(keys: [Int], value: Int) -> [Int : Int] {
    var d: [Int : Int] = [:]
    for key in keys {
        d[key] = value
    }
    var keys = d.keys
    for (i, k) in keys.enumerated() {
        if let val = d[k], d[i + 1] == val {
            d[i + 1] = nil
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
            
assert(f(keys: [1, 2, 1, 1], value: 3) == [:] as [Int : Int])
