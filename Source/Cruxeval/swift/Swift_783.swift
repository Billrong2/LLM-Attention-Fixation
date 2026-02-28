/// 
func f(text: String, comparison: String) -> Int {
    let length = comparison.count
    if length <= text.count {
        for i in 0..<length {
            if comparison[comparison.index(comparison.startIndex, offsetBy: length - i - 1)] != text[text.index(text.endIndex, offsetBy: -i - 1)] {
                return i
            }
        }
    }
    return length
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
            
assert(f(text: "managed", comparison: "") == 0)
