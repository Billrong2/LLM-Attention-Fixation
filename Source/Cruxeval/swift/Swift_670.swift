func f(a: [AnyHashable], b: [Int]) -> [Int] {
    var d = Dictionary(uniqueKeysWithValues: zip(a, b))
    var sortedA = a
    sortedA.sort { d[$0]! > d[$1]! }
    return sortedA.compactMap { d.removeValue(forKey: $0) }
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
            
assert(f(a: ["12", "ab"], b: [2, 2]) == [2, 2])
