/// 
func f(l: [String], c: String) -> String {
    return l.joined(separator: c)
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
            
assert(f(l: ["many", "letters", "asvsz", "hello", "man"], c: "") == "manylettersasvszhelloman")
