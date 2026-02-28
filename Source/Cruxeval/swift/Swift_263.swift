func f(base: [String], delta: [[String]]) -> [String] {
    var updatedBase = base
    
    for j in 0..<delta.count {
        for i in 0..<updatedBase.count {
            if updatedBase[i] == delta[j][0] {
                assert(delta[j][1] != updatedBase[i])
                updatedBase[i] = delta[j][1]
            }
        }
    }
    
    return updatedBase
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
            
assert(f(base: ["gloss", "banana", "barn", "lawn"], delta: [] as [[String]]) == ["gloss", "banana", "barn", "lawn"])
