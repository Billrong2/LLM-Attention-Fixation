/// 
func f(text: String) -> String {
    let length = text.count / 2
    let leftHalf = text.prefix(length)
    let rightHalf = String(text.suffix(from: text.index(text.startIndex, offsetBy: length)).reversed())
    return leftHalf + rightHalf
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
            
assert(f(text: "n") == "n")
