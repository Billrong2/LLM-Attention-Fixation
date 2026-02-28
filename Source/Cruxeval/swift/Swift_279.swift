/// 
func f(text: String) -> String {
    var ans = ""
    var text = text
    while text != "" {
        let parts = text.split(separator: "(", maxSplits: 1, omittingEmptySubsequences: false)
        let x = String(parts[0])
        let remainder = parts.count > 1 ? String(parts[1]) : ""
        ans = x + "(" + ans
        if remainder != "" {
            ans += "|"
            text = remainder
        }
    }
    return ans
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
            
assert(f(text: "") == "")
