/// 
func f(text: String) -> [String] {
    var new_text: [String] = []
    for i in 0..<(text.count / 3) {
        let startIndex = text.index(text.startIndex, offsetBy: i * 3)
        let endIndex = text.index(text.startIndex, offsetBy: i * 3 + 3)
        let substr = String(text[startIndex..<endIndex])
        new_text.append("< \(substr) level=\(i) >")
    }
    
    let last_item = String(text.suffix(text.count - (text.count / 3) * 3))
    new_text.append("< \(last_item) level=\(text.count / 3) >")
    
    return new_text
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
            
assert(f(text: "C7") == ["< C7 level=0 >"])
