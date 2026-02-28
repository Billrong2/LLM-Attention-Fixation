/// 
func f(text: String, n: Int) -> String {
    if text.count <= 2 {
        return text
    }
    let leadingChars = String(repeating: text.first!, count: n - text.count + 1)
    return leadingChars + String(text.suffix(text.count - 1).dropLast())
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
            
assert(f(text: "g", n: 15) == "g")
