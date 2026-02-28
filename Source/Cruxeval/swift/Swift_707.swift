/// 
func f(text: String, position: Int) -> String {
    let length = text.count
    var index = position % (length + 1)
    if position < 0 || index < 0 {
        index = -1
    }
    var new_text = Array(text)
    new_text.remove(at: index)
    return String(new_text)
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
            
assert(f(text: "undbs l", position: 1) == "udbs l")
