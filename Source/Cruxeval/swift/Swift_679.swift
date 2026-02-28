/// 
func f(text: String) -> Bool {
    if text.isEmpty {
        return false
    }
    let firstChar = text.first!
    if firstChar.isNumber {
        return false
    }
    for lastChar in text {
        if (lastChar != "_") && !lastChar.isLetter && !lastChar.isNumber && lastChar != "_" {
            return false
        }
    }
    return true
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
            
assert(f(text: "meet") == true)
