func f(text: String) -> Int {
    let k = text.split(separator: "\n", maxSplits: Int.max, omittingEmptySubsequences: false)
    var i = 0
    for j in k {
        if j.isEmpty {
            return i
        }
        i += 1
    }
    return -1
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
            
assert(f(text: "2 m2 \n\nbike") == 1)
