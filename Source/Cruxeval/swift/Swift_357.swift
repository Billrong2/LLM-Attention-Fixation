/// 
func f(s: String) -> String {
    var r: [Character] = []
    for i in stride(from: s.count - 1, through: 0, by: -1) {
        r.append(s[s.index(s.startIndex, offsetBy: i)])
    }
    return String(r)
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
            
assert(f(s: "crew") == "werc")
