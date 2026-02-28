func f(text: String, char: String) -> String {
    var text = text
    if !text.isEmpty {
        if text.hasPrefix(char) {
            text = String(text.dropFirst(char.count))
        }
        if let lastChar = text.last {
            text = String(text.dropLast())
            text.append(Character(String(lastChar).uppercased()))
        }
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
            
assert(f(text: "querist", char: "u") == "querisT")
