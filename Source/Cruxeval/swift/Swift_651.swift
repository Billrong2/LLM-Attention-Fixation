/// 
func f(text: String, letter: String) -> String {
    let letter = letter.uppercased()
    let text = String(text.map { char in letter == String(char).lowercased() ? Character(letter) : char })
    return text.prefix(1).uppercased() + text.dropFirst()
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
            
assert(f(text: "E wrestled evil until upperfeat", letter: "e") == "E wrestled evil until upperfeat")
