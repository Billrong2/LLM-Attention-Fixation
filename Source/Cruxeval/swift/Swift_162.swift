/// 
func f(text: String) -> String {
    var result = ""
    for char in text {
        if char.isLetter || char.isNumber {
            result += String(char).uppercased()
        }
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
            
assert(f(text: "с bishop.Swift") == "СBISHOPSWIFT")
