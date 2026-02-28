func f(text: String) -> Int {
    let s = text.split(separator: "\n", omittingEmptySubsequences: false)
    return s.count
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
            
assert(f(text: "145\n\n12fjkjg") == 3)
