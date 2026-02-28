/// 
func f(text: String, suffix: String) -> String {
    var updatedText = text
    if updatedText.hasSuffix(suffix) {
        let lastIndex = updatedText.index(updatedText.endIndex, offsetBy: -1)
        let lastCharacter = updatedText[lastIndex]
        updatedText.removeLast()
        updatedText.append(lastCharacter.uppercased() == String(lastCharacter) ? lastCharacter.lowercased() : lastCharacter.uppercased())
    }
    return updatedText
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
            
assert(f(text: "damdrodm", suffix: "m") == "damdrodM")
