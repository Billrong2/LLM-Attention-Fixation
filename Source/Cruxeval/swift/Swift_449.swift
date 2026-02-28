/// 
func f(x: String) -> Bool {
    let n = x.count
    var i = 0
    while i < n && x[x.index(x.startIndex, offsetBy: i)].isNumber {
        i += 1
    }
    return i == n
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
            
assert(f(x: "1") == true)
