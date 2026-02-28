/// 
func f(char: String) -> String {
    if !["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"].contains(char) {
        return "None"
    }
    if ["A", "E", "I", "O", "U"].contains(char) {
        return char.lowercased()
    }
    return char.uppercased()
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
            
assert(f(char: "o") == "O")
