/// 
func f(s: String, suffix: String) -> String {
    if suffix.isEmpty {
        return s
    }
    
    var result = s
    
    while result.hasSuffix(suffix) {
        result = String(result.dropLast(suffix.count))
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
            
assert(f(s: "ababa", suffix: "ab") == "ababa")
