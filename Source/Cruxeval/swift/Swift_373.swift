func f(orig: [Int]) -> [Int] {
    var copy = orig
    copy.append(100)
    _ = copy.popLast()
    return copy
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
            
assert(f(orig: [1, 2, 3]) == [1, 2, 3])
