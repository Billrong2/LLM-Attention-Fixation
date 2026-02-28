/// 
func f(text: String) -> Bool {
    if text == "42.42" {
        return true
    }
    for i in 3..<(text.count - 3) {
        let index = text.index(text.startIndex, offsetBy: i)
        if text[index] == "." && text.prefix(i).allSatisfy({ $0.isNumber }) && text.suffix(from: index).allSatisfy({ $0.isNumber }) {
            return true
        }
    }
    return false
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
            
assert(f(text: "123E-10") == false)
