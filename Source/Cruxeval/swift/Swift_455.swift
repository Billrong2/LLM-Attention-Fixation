/// 
func f(text: String) -> String {
    var uppers = 0
    for c in text {
        if c.isUppercase {
            uppers += 1
        }
    }
    
    return uppers >= 10 ? text.uppercased() : text
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
            
assert(f(text: "?XyZ") == "?XyZ")
