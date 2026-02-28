/// 
func f(text: String, m: Int, n: Int) -> String {
    var text = text + text.prefix(m) + text.suffix(text.count - n)
    var result = ""
    for i in n..<(text.count - m) {
        result = String(text[text.index(text.startIndex, offsetBy: i)]) + result
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
            
assert(f(text: "abcdefgabc", m: 1, n: 2) == "bagfedcacbagfedc")
