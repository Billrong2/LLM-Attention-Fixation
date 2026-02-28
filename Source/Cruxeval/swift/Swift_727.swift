/// 
func f(numbers: [String], prefix: String) -> [String] {
    return numbers.map { n in
        if n.count > prefix.count && n.hasPrefix(prefix) {
            return String(n.dropFirst(prefix.count))
        } else {
            return n
        }
    }.sorted()
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
            
assert(f(numbers: ["ix", "dxh", "snegi", "wiubvu"], prefix: "") == ["dxh", "ix", "snegi", "wiubvu"])
