func f(s1: String, s2: String) -> Bool {
    var s1 = s1
    let s2Chars = Array(s2)
    for _ in 0..<(s2.count + s1.count) {
        s1.append(s1.removeFirst())
        if s1.contains(where: { s2Chars.contains($0) }) {
            return true
        }
    }
    return false
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
            
assert(f(s1: "Hello", s2: ")") == false)
