/// 
func f(text: String) -> String {
    var i = 0
    while i < text.count && text[text.index(text.startIndex, offsetBy: i)].isWhitespace {
        i += 1
    }
    if i == text.count {
        return "space"
    }
    return "no"
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
            
assert(f(text: "     ") == "space")
