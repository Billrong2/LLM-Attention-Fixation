/// 
func f(text: String) -> Bool {
    let valid_chars: [Character] = ["-", "_", "+", ".", "/", " "]
    let uppercasedText = text.uppercased()
    
    for char in uppercasedText {
        if !char.isLetter && !valid_chars.contains(char) {
            return false
        }
    }
    
    return true
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
            
assert(f(text: "9.twCpTf.H7 HPeaQ^ C7I6U,C:YtW") == false)
