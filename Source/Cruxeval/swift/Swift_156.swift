func f(text: String, limit: Int, char: Character) -> String {
    if limit < text.count {
        return String(text.prefix(limit))
    }
    
    var paddedText = text
    for _ in 0..<(limit - text.count) {
        paddedText.append(char)
    }
    
    return paddedText
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
            
assert(f(text: "tqzym", limit: 5, char: "c") == "tqzym")
