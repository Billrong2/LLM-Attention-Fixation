/// 
func f(s: [Int]) -> Int {
    var s = s
    while s.count > 1 {
        s.removeAll()
        s.append(s.count)
    }
    return s.removeLast()
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
            
assert(f(s: [6, 1, 2, 3]) == 0)
