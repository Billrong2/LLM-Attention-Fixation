/// 
func f(seq: [String], v: String) -> [String] {
    var result: [String] = []
    for i in seq {
        if i.hasSuffix(v) {
            result.append(i + i)
        }
    }
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
            
assert(f(seq: ["oH", "ee", "mb", "deft", "n", "zz", "f", "abA"], v: "zz") == ["zzzz"])
