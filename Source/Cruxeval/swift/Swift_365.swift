func f(n: String, s: String) -> String {
    if s.hasPrefix(n) {
        let splitted = s.split(separator: Character(n), maxSplits: 1)
        if let pre = splitted.first {
            return String(pre) + n + String(s.dropFirst(n.count))
        }
    }
    return s
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
            
assert(f(n: "xqc", s: "mRcwVqXsRDRb") == "mRcwVqXsRDRb")
