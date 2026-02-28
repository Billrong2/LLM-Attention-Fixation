func f(strs: String) -> String {
    var strs = strs.split(separator: " ").map { String($0) }
    for i in stride(from: 1, to: strs.count, by: 2) {
        strs[i] = String(strs[i].reversed())
    }
    return strs.joined(separator: " ")
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
            
assert(f(strs: "K zBK") == "K KBz")
