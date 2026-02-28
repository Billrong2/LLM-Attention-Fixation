/// 
func f(text: String) -> String {
    let length = text.count
    var index = 0
    while index < length && text[text.index(text.startIndex, offsetBy: index)].isWhitespace {
        index += 1
    }
    return String(text[text.index(text.startIndex, offsetBy: index)..<text.index(text.startIndex, offsetBy: min(index+5, length))])
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
            
assert(f(text: "-----\t\n\tth\n-----") == "-----")
