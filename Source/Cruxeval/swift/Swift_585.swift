/// 
func f(text: String) -> String {
    var count = text.filter({$0 == text.first}).count
    var ls = Array(text)
    for _ in 0..<count {
        ls.removeFirst()
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
            
assert(f(text: ";,,,?") == ",,,?")
