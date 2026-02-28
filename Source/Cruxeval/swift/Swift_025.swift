func f(d: [String : Int]) -> [String : Int] {
    var dCopy = d
    dCopy.remove(at: dCopy.startIndex)
    return dCopy
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
            
assert(f(d: ["l" : 1, "t" : 2, "x:" : 3]) == ["l" : 1, "t" : 2])
