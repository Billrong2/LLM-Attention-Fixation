/// 
func f(n: String) -> String {
    if n.contains(".") {
        return String(Int(Double(n)! + 2.5))
    }
    return n
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
            
assert(f(n: "800") == "800")
