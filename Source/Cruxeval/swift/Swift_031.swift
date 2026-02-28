/// 
func f(string: String) -> Int {
    var upper = 0
    for c in string {
        if c.isUppercase {
            upper += 1
        }
    }
    return upper * (upper % 2 == 0 ? 2 : 1)
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
            
assert(f(string: "PoIOarTvpoead") == 8)
