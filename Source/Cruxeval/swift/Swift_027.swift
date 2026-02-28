/// 
func f(w: String) -> Bool {
    var ls = Array(w)
    var omw = ""
    while ls.count > 0 {
        omw += String(ls.removeFirst())
        if ls.count * 2 > w.count {
            return w.dropFirst(ls.count) == omw
        }
    }
    return false
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
            
assert(f(w: "flak") == false)
