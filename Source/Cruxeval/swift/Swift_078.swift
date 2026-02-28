func f(text: String) -> String {
    let uppercaseLetters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    let lowercaseLetters = Array("abcdefghijklmnopqrstuvwxyz")
    
    if !text.isEmpty && text == text.uppercased() {
        let cs = Dictionary(uniqueKeysWithValues: zip(uppercaseLetters, lowercaseLetters))
        return String(text.map { cs[$0, default: $0] })
    }
    return text.lowercased().prefix(3).description
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
            
assert(f(text: "mTYWLMwbLRVOqNEf.oLsYkZORKE[Ko[{n") == "mty")
