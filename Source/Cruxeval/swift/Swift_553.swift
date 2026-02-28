/// 
func f(text: String, count: Int) -> String {
    var text = text
    for _ in 0..<count {
        text = String(text.reversed())
    }
    return text
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
            
assert(f(text: "439m2670hlsw", count: 3) == "wslh0762m934")
