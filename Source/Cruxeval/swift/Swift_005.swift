func f(text: String, lower: String, upper: String) -> (Int, String) {
    var count = 0
    var new_text: [Character] = []
    for char in text {
        let newChar = char.isNumber ? Character(lower) : Character(upper)
        if ["p", "C"].contains(newChar) {
            count += 1
        }
        new_text.append(newChar)
    }
    return (count, String(new_text))
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
            
assert(f(text: "DSUWeqExTQdCMGpqur", lower: "a", upper: "x") == (0, "xxxxxxxxxxxxxxxxxx"))
