/// 
func f(text: String) -> String {
    var result = [Character]()
    
    for char in text {
        if !char.isASCII {
            return "False"
        } else if char.isLetter {
            result.append(Character(char.uppercased()))
        } else {
            result.append(char)
        }
    }
    
    return String(result)
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
            
assert(f(text: "ua6hajq") == "UA6HAJQ")
