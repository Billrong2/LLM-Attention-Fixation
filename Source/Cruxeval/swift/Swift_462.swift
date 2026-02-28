func f(text: String, value: String) -> String {
    let length = text.count
    let letters = Array(text)
    if !letters.contains(Character(value)) {
        let newValue = String(letters[0])
        return String(repeating: newValue, count: length)
    }
    return String(repeating: value, count: length)
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
            
assert(f(text: "ldebgp o", value: "o") == "oooooooo")
