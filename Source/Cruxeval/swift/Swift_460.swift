/// 
func f(text: String, amount: Int) -> String {
    let length = text.count
    var pre_text = "|"
    if amount >= length {
        let extraSpace = amount - length
        pre_text += String(repeating: " ", count: extraSpace / 2)
        return pre_text + text + pre_text
    }
    return text
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
            
assert(f(text: "GENERAL NAGOOR", amount: 5) == "GENERAL NAGOOR")
