/// 
func f(text: String) -> String {
    if text.isEmpty {
        return ""
    }
    
    let lowercasedText = text.lowercased()
    let firstChar = lowercasedText.prefix(1).uppercased()
    let restOfString = String(lowercasedText.dropFirst())
    
    return firstChar + restOfString
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
            
assert(f(text: "xzd") == "Xzd")
