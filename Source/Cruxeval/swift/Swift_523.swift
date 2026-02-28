func f(text: String) -> String {
    var textArray = Array(text)
    for i in stride(from: textArray.count - 1, through: 0, by: -1) {
        if textArray[i].isWhitespace {
            textArray[i] = "&"
            textArray.insert(contentsOf: "nbsp;", at: i+1)
        }
    }
    return String(textArray)
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
            
assert(f(text: "   ") == "&nbsp;&nbsp;&nbsp;")
