/// 
func f(text: String) -> [String] {
    var text_arr: [String] = []
    for j in 0..<text.count {
        text_arr.append(String(text.suffix(text.count - j)))
    }
    return text_arr
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
            
assert(f(text: "123") == ["123", "23", "3"])
