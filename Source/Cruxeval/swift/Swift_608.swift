/// 
func f(aDict: [AnyHashable : AnyHashable]) -> [AnyHashable : AnyHashable] {
    return Dictionary(uniqueKeysWithValues: aDict.map { ($1, $0) })
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
            
assert(f(aDict: [1 : 1, 2 : 2, 3 : 3]) == [1 : 1, 2 : 2, 3 : 3])
