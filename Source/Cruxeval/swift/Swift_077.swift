func f(text: String, character: String) -> String {
    guard let char = character.first, let index = text.lastIndex(of: char) else {
        return ""
    }
    let subject = String(text[index...])
    let count = text.filter { $0 == char }.count
    return String(repeating: subject, count: count)
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
            
assert(f(text: "h ,lpvvkohh,u", character: "i") == "")
