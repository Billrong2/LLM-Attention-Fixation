func f(d: [String : Int]) -> (String, [String : Int]) {
    let keys = Array(d.keys)
    let i = keys.count - 1
    let key = keys[i]
    var newDict = d
    newDict[key] = nil
    return (key, newDict)
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
            
assert(f(d: ["e" : 1, "d" : 2, "c" : 3]) == ("c", ["e" : 1, "d" : 2]))
