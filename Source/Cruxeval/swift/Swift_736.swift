func f(text: String, insert: String) -> String {
    let whitespaces: Set<Character> = ["\u{0009}", "\u{000D}", "\u{000B}", " ", "\u{000C}", "\u{000A}"]
    var clean = ""
    for char in text {
        if whitespaces.contains(char) {
            clean += insert
        } else {
            clean.append(char)
        }
    }
    return clean
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
            
assert(f(text: "pi wa", insert: "chi") == "pichiwa")
