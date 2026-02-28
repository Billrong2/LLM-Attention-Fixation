/// 
func f(text: String, search: String) -> Bool {
    return search.hasPrefix(text)
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
            
assert(f(text: "123", search: "123eenhas0") == true)
