/// 
func f(text: String, prefix: String) -> String {
    var idx = 0
    for letter in prefix {
        if text[text.index(text.startIndex, offsetBy: idx)] != letter {
            return ""
        }
        idx += 1
    }
    return String(text.suffix(text.count - idx))
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
            
assert(f(text: "bestest", prefix: "bestest") == "")
