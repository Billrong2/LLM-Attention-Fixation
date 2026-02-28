/// 
func f(string: String, substring: String) -> String {
    var string = string
    while string.hasPrefix(substring) {
        string = String(string.dropFirst(substring.count))
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
            
assert(f(string: "", substring: "A") == "")
