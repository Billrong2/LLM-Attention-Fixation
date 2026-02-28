/// 
func f(string: String) -> String {
    var l = Array(string)
    for i in stride(from: l.count - 1, through: 0, by: -1) {
        if l[i] != " " {
            break
        }
        l.remove(at: i)
    }
    return String(l)
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
            
assert(f(string: "    jcmfxv     ") == "    jcmfxv")
