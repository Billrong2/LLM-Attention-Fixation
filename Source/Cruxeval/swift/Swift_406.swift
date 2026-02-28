func f(text: String) -> Bool {
    var ls = Array(text)
    ls[0] = Character(String(ls.last!).uppercased())
    ls[ls.count-1] = Character(String(ls.first!).uppercased())
    return String(ls) == text
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
            
assert(f(text: "Josh") == false)
