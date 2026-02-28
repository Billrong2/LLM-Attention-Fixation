/// 
func f(s1: String, s2: String) -> String {
    var result = s2
    if result.hasSuffix(s1) {
        result = String(result.dropLast(s1.count))
    }
    return result
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
            
assert(f(s1: "he", s2: "hello") == "hello")
