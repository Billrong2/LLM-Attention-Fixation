/// 
func f(str: String, toget: String) -> String {
    if str.hasPrefix(toget) {
        return String(str.dropFirst(toget.count))
    } else {
        return str
    }
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
            
assert(f(str: "fnuiyh", toget: "ni") == "fnuiyh")
