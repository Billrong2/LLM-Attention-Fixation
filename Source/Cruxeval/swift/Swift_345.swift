func f(a: String, b: String) -> (String, String) {
    if a < b {
        return (b, a)
    }
    return (a, b)
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
            
assert(f(a: "ml", b: "mv") == ("mv", "ml"))
