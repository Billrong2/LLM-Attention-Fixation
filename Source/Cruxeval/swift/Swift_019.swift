/// 
func f(x: String, y: String) -> String {
    let tmp = String(y.reversed().map { $0 == "9" ? "0" : "9" })
    if let _ = Int(x), let _ = Int(tmp) {
        return x + tmp
    } else {
        return x
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
            
assert(f(x: "", y: "sdasdnakjsda80") == "")
