/// 
func f(s: String) -> Bool {
    return s.count == s.filter({ $0 == "0" || $0 == "1" }).count
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
            
assert(f(s: "102") == false)
