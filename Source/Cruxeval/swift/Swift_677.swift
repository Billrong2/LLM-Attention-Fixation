/// 
func f(text: String, length: Int) -> String {
    var length = length < 0 ? -length : length
    var output = ""
    for idx in 0..<length {
        let charIndex = text.index(text.startIndex, offsetBy: idx % text.count)
        if text[charIndex] != " " {
            output.append(text[charIndex])
        } else {
            break
        }
    }
    return output
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
            
assert(f(text: "I got 1 and 0.", length: 5) == "I")
