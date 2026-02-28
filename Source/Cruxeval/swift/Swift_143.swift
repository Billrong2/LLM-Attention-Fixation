/// 
func f(s: String, n: String) -> Bool {
    return s.lowercased() == n.lowercased()
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
            
assert(f(s: "daaX", n: "daaX") == true)
