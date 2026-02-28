/// 
func f(d: [String : AnyHashable], count: Int) -> [String : AnyHashable] {
    var newDict: [String: AnyHashable] = [:]
    for _ in 0..<count {
        var tempDict = d
        newDict.merge(tempDict) { (_, new) in new }
    }
    return newDict
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
            
assert(f(d: ["a" : 2, "b" : [] as [AnyHashable], "c" : [:] as [AnyHashable : AnyHashable]], count: 0) == [:] as [String : AnyHashable])
