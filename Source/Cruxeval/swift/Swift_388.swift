/// 
func f(text: String, characters: String) -> String {
    var characterList = Array(characters) + [" ", "_"]
    
    var i = 0
    while i < text.count && characterList.contains(text[text.index(text.startIndex, offsetBy: i)]) {
        i += 1
    }
    
    return String(text.suffix(from: text.index(text.startIndex, offsetBy: i)))
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
            
assert(f(text: "2nm_28in", characters: "nm") == "2nm_28in")
