/// 
func f(string: String) -> String {
    var str = string
    while !str.isEmpty {
        if str.last!.isLetter {
            return str
        }
        str.removeLast()
    }
    return str
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
            
assert(f(string: "--4/0-209") == "")
