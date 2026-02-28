func f(s: String) -> Bool {
    var l = Array(s)
    for i in 0..<l.count {
        l[i] = Character(l[i].lowercased())
        if !l[i].isNumber {
            return false
        }
    }
    return true
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
            
assert(f(s: "") == true)
