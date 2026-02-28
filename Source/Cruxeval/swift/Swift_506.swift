/// 
func f(n: Int) -> String {
    var p = ""
    if n % 2 == 1 {
        p += "sn"
    } else {
        return String(n * n)
    }
    for x in 1...n {
        if x % 2 == 0 {
            p += "to"
        } else {
            p += "ts"
        }
    }
    return p
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
            
assert(f(n: 1) == "snts")
