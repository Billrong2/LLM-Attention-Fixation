/// 
func f(text: String, char: String) -> Bool {
    return char.lowercased() == char && text.lowercased() == text
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
            
assert(f(text: "abc", char: "e") == true)
