/// 
func f(text: String, n: Int) -> String {
    let length = text.count
    return String(text[text.index(text.startIndex, offsetBy: length*(n%4))..<text.endIndex])
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
            
assert(f(text: "abc", n: 1) == "")
