/// 
func f(text: String) -> String {
    var letters = ""
    for i in 0..<text.count {
        if text[text.index(text.startIndex, offsetBy: i)].isLetter || text[text.index(text.startIndex, offsetBy: i)].isNumber {
            letters += String(text[text.index(text.startIndex, offsetBy: i)] )
        }
    }
    return letters
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
            
assert(f(text: "we@32r71g72ug94=(823658*!@324") == "we32r71g72ug94823658324")
