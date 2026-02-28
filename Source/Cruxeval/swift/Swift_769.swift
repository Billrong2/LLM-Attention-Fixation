/// 
func f(text: String) -> String {
    var textList = text.map { String($0) }
    for (index, char) in textList.enumerated() {
        textList[index] = char.uppercased() == char ? char.lowercased() : char.uppercased()
    }
    
    return textList.joined()
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
            
assert(f(text: "akA?riu") == "AKa?RIU")
