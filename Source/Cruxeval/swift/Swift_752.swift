/// 
func f(s: String, amount: Int) -> String {
    return String(repeating: "z", count: max(amount - s.count, 0)) + s
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
            
assert(f(s: "abc", amount: 8) == "zzzzzabc")
