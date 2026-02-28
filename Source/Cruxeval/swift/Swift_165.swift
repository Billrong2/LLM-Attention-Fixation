/// 
func f(text: String, lower: Int, upper: Int) -> Bool {
    return text[text.index(text.startIndex, offsetBy: lower)..<text.index(text.startIndex, offsetBy: upper)].allSatisfy { $0.isASCII }
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
            
assert(f(text: "=xtanp|sugv?z", lower: 3, upper: 6) == true)
