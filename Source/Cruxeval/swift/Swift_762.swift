func f(text: String) -> String {
    let lowercasedText = text.lowercased()
    let capitalizedText = lowercasedText.prefix(1).uppercased() + lowercasedText.dropFirst()
    return String(lowercasedText.prefix(1)) + String(capitalizedText.dropFirst())
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
            
assert(f(text: "this And cPanel") == "this and cpanel")
