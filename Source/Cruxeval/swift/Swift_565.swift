/// 
func f(text: String) -> Int {
    return text.compactMap { char in "aeiou".contains(char) ? text.firstIndex(of: char)?.utf16Offset(in: text) : nil }.max() ?? -1
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
            
assert(f(text: "qsqgijwmmhbchoj") == 13)
