/// 
func f(a: String, b: String, c: String, d: String) -> String {
    return a.isEmpty ? c : b
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
            
assert(f(a: "CJU", b: "BFS", c: "WBYDZPVES", d: "Y") == "BFS")
