/// 
func f(s: String) -> String {
    var a = s.filter { $0 != " " }
    var b = a
    for c in a.reversed() {
        if c == " " {
            b.removeLast()
        } else {
            break
        }
    }
    return b
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
            
assert(f(s: "hi ") == "hi")
