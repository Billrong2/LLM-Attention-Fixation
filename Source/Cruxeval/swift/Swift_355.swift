/// 
func f(text: String, prefix: String) -> String {
    return String(text.suffix(text.count - prefix.count))
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
            
assert(f(text: "123x John z", prefix: "z") == "23x John z")
