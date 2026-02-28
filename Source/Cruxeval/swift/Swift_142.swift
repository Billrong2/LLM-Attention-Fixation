/// 
func f(x: String) -> String {
    if x == x.lowercased() {
        return x
    } else {
        return String(x.reversed())
    }
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
            
assert(f(x: "ykdfhp") == "ykdfhp")
