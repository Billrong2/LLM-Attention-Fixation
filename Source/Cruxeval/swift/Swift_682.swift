/// 
func f(text: String, length: Int, index: Int) -> String {
    let ls = text.split(separator: " ", maxSplits: index).map { String($0) }
    let result = ls.map { String($0.prefix(length)) }.joined(separator: "_")
    return result
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
            
assert(f(text: "hypernimovichyp", length: 2, index: 2) == "hy")
