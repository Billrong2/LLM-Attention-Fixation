func f(a: [String : [String]], b: [String : String]) -> [String : [String]] {
    var mutableA = a
    for (key, value) in b {
        if mutableA[key] == nil {
            mutableA[key] = [value]
        } else {
            mutableA[key]?.append(value)
        }
    }
    return mutableA
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
            
assert(f(a: [:] as [String : [String]], b: ["foo" : "bar"]) == ["foo" : ["bar"]])
