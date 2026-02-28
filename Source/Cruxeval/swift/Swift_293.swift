/// 
func f(text: String) -> String {
    var s = text.lowercased()
    for i in 0..<s.count {
        if s[s.index(s.startIndex, offsetBy: i)] == "x" {
            return "no"
        }
    }
    return text.uppercased()
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
            
assert(f(text: "dEXE") == "no")
