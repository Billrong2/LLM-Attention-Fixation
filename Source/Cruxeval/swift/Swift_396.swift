func f(ets: [Int : Int]) -> [Int : Int] {
    var mutableEts = ets
    for (key, value) in mutableEts {
        mutableEts[key] = value * value
    }
    return mutableEts
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
            
assert(f(ets: [:] as [Int : Int]) == [:] as [Int : Int])
