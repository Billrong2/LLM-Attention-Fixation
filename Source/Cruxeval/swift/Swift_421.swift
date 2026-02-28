/// 
func f(s: String, n: Int) -> String {
    if s.count < n {
        return s
    } else {
        return String(s.dropFirst(n))
    }
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
            
assert(f(s: "try.", n: 5) == "try.")
