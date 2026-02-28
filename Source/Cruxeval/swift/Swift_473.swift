/// 
func f(text: String, value: String) -> String {
    var indexes = [Int]()
    for i in 0..<text.count {
        if text[text.index(text.startIndex, offsetBy: i)] == Character(value) {
            indexes.append(i)
        }
    }
    var new_text = Array(text)
    for i in indexes.reversed() {
        new_text.remove(at: i)
    }
    return String(new_text)
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
            
assert(f(text: "scedvtvotkwqfoqn", value: "o") == "scedvtvtkwqfqn")
