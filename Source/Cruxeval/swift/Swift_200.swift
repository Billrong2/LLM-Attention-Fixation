/// 
func f(text: String, value: String) -> String {
    var length = text.count
    var index = 0
    var result = value
    while length > 0 {
        result = String(text[text.index(text.startIndex, offsetBy: index)]) + result
        length -= 1
        index += 1
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
            
assert(f(text: "jao mt", value: "house") == "tm oajhouse")
