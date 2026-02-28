/// 
func f(text: String, pre: String) -> String {
    if !text.hasPrefix(pre) {
        return text
    }
    return String(text.dropFirst(pre.count))
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
            
assert(f(text: "@hihu@!", pre: "@hihu") == "@!")
