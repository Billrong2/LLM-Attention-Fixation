/// 
func f(st: String, pattern: [String]) -> Bool {
    var str = st
    for p in pattern {
        if !str.hasPrefix(p) {
            return false
        }
        str = String(str.dropFirst(p.count))
    }
    return true
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
            
assert(f(st: "qwbnjrxs", pattern: ["jr", "b", "r", "qw"]) == false)
