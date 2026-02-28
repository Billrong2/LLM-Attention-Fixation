/// 
func f(text: String) -> String {
    var short = ""
    for c in text {
        if c.isLowercase {
            short += String(c)
        }
    }
    return short
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
            
assert(f(text: "980jio80jic kld094398IIl ") == "jiojickldl")
