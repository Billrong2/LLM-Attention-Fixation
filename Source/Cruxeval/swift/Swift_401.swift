/// 
func f(text: String, suffix: String) -> String {
    if !suffix.isEmpty && text.hasSuffix(suffix) {
        return String(text.prefix(text.count - suffix.count))
    }
    return text
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
            
assert(f(text: "mathematics", suffix: "example") == "mathematics")
