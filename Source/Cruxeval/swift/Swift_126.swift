/// 
func f(text: String) -> String {
    let s = text.split(separator: "o", maxSplits: 1, omittingEmptySubsequences: true)
    let div = s.count == 1 ? "-" : s[0]
    let div2 = s.count == 1 ? "-" : s[1]
    return s.count == 1 ? "-" + s[0] : s[0] + "o" + s[0] + "o" + s[1]
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
            
assert(f(text: "kkxkxxfck") == "-kkxkxxfck")
