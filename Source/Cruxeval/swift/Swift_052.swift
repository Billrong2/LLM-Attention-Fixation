/// 
func f(text: String) -> String {
    var a = ""
    for char in text {
        if !char.isNumber {
            a.append(char)
        }
    }
    return a
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
            
assert(f(text: "seiq7229 d27") == "seiq d")
