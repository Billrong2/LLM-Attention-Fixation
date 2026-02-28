func f(x: String) -> String {
    return x.reversed().map { String($0) }.joined(separator: " ")
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
            
assert(f(x: "lert dna ndqmxohi3") == "3 i h o x m q d n   a n d   t r e l")
