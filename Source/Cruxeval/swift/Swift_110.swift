/// 
func f(text: String) -> Int {
    var a = [""]
    var b = ""
    for i in text {
        if !i.isWhitespace {
            a.append(b)
            b = ""
        } else {
            b += String(i)
        }
    }
    return a.count
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
            
assert(f(text: "       ") == 1)
