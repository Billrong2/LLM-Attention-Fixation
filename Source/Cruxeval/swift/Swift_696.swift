/// 
func f(text: String) -> Int {
    var s = 0
    for i in 1..<text.count {
        s += text.prefix(i).count
    }
    return s
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
            
assert(f(text: "wdj") == 3)
