/// 
func f(text: String) -> String {
    var ls = Array(text)
    let total = (text.count - 1) * 2
    for i in 1...total {
        if i % 2 == 1 {
            ls.append("+")
        } else {
            ls.insert("+", at: 0)
        }
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
            
assert(f(text: "taole") == "++++taole++++")
