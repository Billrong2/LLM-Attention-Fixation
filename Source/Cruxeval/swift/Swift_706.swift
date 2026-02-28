/// 
func f(r: String, w: String) -> [String] {
    var a: [String] = []
    if r.first == w.first && w.last == r.last {
        a.append(r)
        a.append(w)
    } else {
        a.append(w)
        a.append(r)
    }
    return a
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
            
assert(f(r: "ab", w: "xy") == ["xy", "ab"])
