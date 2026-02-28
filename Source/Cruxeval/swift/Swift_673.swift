/// 
func f(string: String) -> String {
    if string.uppercased() == string {
        return string.lowercased()
    } else if string.lowercased() == string {
        return string.uppercased()
    }
    return string
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
            
assert(f(string: "cA") == "cA")
