/// 
func f(text: String, char: String) -> String {
    if !text.hasSuffix(char) {
        return f(text: char + text, char: char)
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
            
assert(f(text: "staovk", char: "k") == "staovk")
