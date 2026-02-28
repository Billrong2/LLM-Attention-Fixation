/// 
func f(s: String, from_c: String, to_c: String) -> String {
    var table = [Character: Character]()
    for (fromChar, toChar) in zip(from_c, to_c) {
        table[fromChar] = toChar
    }
    
    var result = ""
    for char in s {
        if let mappedChar = table[char] {
            result.append(mappedChar)
        } else {
            result.append(char)
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
            
assert(f(s: "aphid", from_c: "i", to_c: "?") == "aph?d")
