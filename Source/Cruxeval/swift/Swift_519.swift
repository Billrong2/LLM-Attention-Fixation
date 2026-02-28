func f(d: [String: Int]) -> [Int: Bool] {
    var mutableD = d
    mutableD["luck"] = 42
    mutableD.removeAll()
    return [1: false, 2: true]
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
            
assert(f(d: [:] as [String : Int]) == [1 : false, 2 : true])
