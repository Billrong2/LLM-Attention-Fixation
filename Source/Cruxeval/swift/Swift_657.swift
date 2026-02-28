func f(text: String) -> String {
    let punctuations = "!.?,:;"
    
    for punctuation in punctuations {
        if text.filter { $0 == punctuation }.count > 1 || text.last == punctuation {
            return "no"
        }
    }
    
    return text.prefix(1).uppercased() + text.dropFirst().lowercased()
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
            
assert(f(text: "djhasghasgdha") == "Djhasghasgdha")
