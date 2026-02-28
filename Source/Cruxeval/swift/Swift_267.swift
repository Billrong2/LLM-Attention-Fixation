/// 
func f(text: String, space: Int) -> String {
    if space < 0 {
        return text
    }
    let length = text.count
    let padLength = length / 2 + space
    let pad = String(repeating: " ", count: max(0, padLength - length))
    return text + pad
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
            
assert(f(text: "sowpf", space: -7) == "sowpf")
