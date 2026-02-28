/// 
func f(s: String, x: String) -> String {
    var count = 0
    var newString = s
    while newString.prefix(x.count) == x && count < s.count - x.count {
        newString = String(newString.dropFirst(x.count))
        count += x.count
    }
    return newString
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
            
assert(f(s: "If you want to live a happy life! Daniel", x: "Daniel") == "If you want to live a happy life! Daniel")
