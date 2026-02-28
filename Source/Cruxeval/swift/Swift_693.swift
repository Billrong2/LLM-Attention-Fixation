/// 
func f(text: String) -> String {
    let n = text.firstIndex(of: "8") ?? text.endIndex
    let count = text.distance(from: text.startIndex, to: n)
    return String(repeating: "x0", count: count)
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
            
assert(f(text: "sa832d83r xd 8g 26a81xdf") == "x0x0")
