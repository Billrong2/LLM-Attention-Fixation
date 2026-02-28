/// 
func f(text: String, letter: String) -> String {
    if let start = text.firstIndex(of: Character(letter)) {
        let startIndex = text.index(after: start)
        return String(text[startIndex...]) + String(text[..<startIndex])
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
            
assert(f(text: "19kefp7", letter: "9") == "kefp719")
