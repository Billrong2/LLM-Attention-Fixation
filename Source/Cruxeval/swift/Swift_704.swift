func f(s: String, n: Int, c: String) -> String {
    var width = c.count * n
    var newString = s
    while newString.count < width {
        newString = c + newString
    }
    return newString
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
            
assert(f(s: ".", n: 0, c: "99") == ".")
