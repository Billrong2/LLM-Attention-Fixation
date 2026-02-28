/// 
func f(s: String, c: String) -> String {
    var splitArray = s.split(separator: " ")
    splitArray.reverse()
    return (c + "  ") + splitArray.joined(separator: "  ")
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
            
assert(f(s: "Hello There", c: "*") == "*  There  Hello")
