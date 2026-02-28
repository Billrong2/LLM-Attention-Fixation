/// 
func f(integer: Int, n: Int) -> String {
    var i = 1
    var text = String(integer)
    while i + text.count < n {
        i += text.count
    }
    return String(repeating: "0", count: i) + text
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
            
assert(f(integer: 8999, n: 2) == "08999")
