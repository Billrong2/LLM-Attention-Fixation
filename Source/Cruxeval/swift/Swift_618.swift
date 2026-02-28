/// 
func f(match: String, fill: String, n: Int) -> String {
    return fill.prefix(n) + match
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
            
assert(f(match: "9", fill: "8", n: 2) == "89")
