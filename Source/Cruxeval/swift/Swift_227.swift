/// 
func f(text: String) -> String {
    var text = text.lowercased()
    let head = text.prefix(1).uppercased()
    let tail = text.dropFirst()
    return head + tail
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
            
assert(f(text: "Manolo") == "Manolo")
