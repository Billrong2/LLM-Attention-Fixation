/// 
func f(n: String) -> Int {
    for i in n {
        if !i.isNumber {
            return -1
        }
    }
    return Int(n) ?? -1
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
            
assert(f(n: "6 ** 2") == -1)
