/// 
func f(text: String) -> String {
    var result = ""
    var i = text.count - 1
    while i >= 0 {
        let index = text.index(text.startIndex, offsetBy: i)
        let c = text[index]
        if c.isLetter {
            result.append(c)
        }
        i -= 1
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
            
assert(f(text: "102x0zoq") == "qozx")
