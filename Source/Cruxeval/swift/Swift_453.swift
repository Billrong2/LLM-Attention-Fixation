/// 
func f(string: String, c: String) -> Bool {
    return string.hasSuffix(c)
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
            
assert(f(string: "wrsch)xjmb8", c: "c") == false)
