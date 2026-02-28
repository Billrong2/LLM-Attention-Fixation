/// 
func f(text: String, delim: String) -> String {
    return String(text.prefix(text.reversed().firstIndex(of: Character(delim))!).reversed())
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
            
assert(f(text: "dsj osq wi w", delim: " ") == "d")
