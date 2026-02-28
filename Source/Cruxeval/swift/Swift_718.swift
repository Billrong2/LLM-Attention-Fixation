/// 
func f(text: String) -> String {
    var t = Array(text)
    var count = text.count
    for i in text {
        if let index = t.firstIndex(of: i) {
            t.remove(at: index)
            count -= 1
        }
    }
    return String(count) + text
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
            
assert(f(text: "ThisIsSoAtrocious") == "0ThisIsSoAtrocious")
