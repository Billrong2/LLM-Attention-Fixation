func f(text: String) -> String {
    var result: [Character] = []
    
    for (i, ch) in text.enumerated() {
        if ch == ch.lowercased().first {
            continue
        }
        if text.count - 1 - i < text.distance(from: text.startIndex, to: text.lastIndex(of: Character(ch.lowercased()))!) {
            result.append(ch)
        }
    }
    
    return String(result)
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
            
assert(f(text: "ru") == "")
