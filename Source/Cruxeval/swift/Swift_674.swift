/// 
func f(text: String) -> String {
    var ls = Array(text)
    var x = ls.count - 1
    while x >= 0 {
        if ls.count <= 1 { break }
        if !("zyxwvutsrqponmlkjihgfedcba".contains(ls[x])) {
            ls.remove(at: x)
        }
        x -= 1
    }
    return String(ls)
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
            
assert(f(text: "qq") == "qq")
