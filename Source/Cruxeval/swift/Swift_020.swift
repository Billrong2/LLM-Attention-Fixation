/// 
func f(text: String) -> String {
    var result = ""
    for i in stride(from: text.count-1, through: 0, by: -1) {
        result += String(text[text.index(text.startIndex, offsetBy: i)])
    }
    return result
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
            
assert(f(text: "was,") == ",saw")
