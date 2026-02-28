/// 
func f(text: String) -> Bool {
    return text.filter({ $0 == "-" }).count == text.count
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
            
assert(f(text: "---123-4") == false)
