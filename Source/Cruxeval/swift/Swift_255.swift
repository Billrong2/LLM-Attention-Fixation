/// 
func f(text: String, fill: String, size: Int) -> String {
    var size = size
    if size < 0 {
        size = -size
    }
    if text.count > size {
        let startIndex = text.index(text.endIndex, offsetBy: -size)
        return String(text[startIndex...])
    }
    let padding = String(repeating: fill, count: size - text.count)
    return padding + text
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
            
assert(f(text: "no asw", fill: "j", size: 1) == "w")
