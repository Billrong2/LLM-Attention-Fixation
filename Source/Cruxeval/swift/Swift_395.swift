/// 
func f(s: String) -> Int {
    for i in 0..<s.count {
        let char = s[s.index(s.startIndex, offsetBy: i)]
        if char.isNumber {
            return i + (char == "0" ? 1 : 0)
        } else if char == "0" {
            return -1
        }
    }
    return -1
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
            
assert(f(s: "11") == 0)
