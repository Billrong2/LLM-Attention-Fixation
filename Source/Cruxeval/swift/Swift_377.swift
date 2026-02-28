/// 
func f(text: String) -> String {
    return text.split(separator: "\n").joined(separator: ", ")
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
            
assert(f(text: "BYE\nNO\nWAY") == "BYE, NO, WAY")
