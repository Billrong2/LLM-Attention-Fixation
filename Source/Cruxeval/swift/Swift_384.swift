func f(text: String, chars: String) -> String {
    var new_text = text
    let charsArray = Array(chars)
    var textArray = Array(text)
    
    while new_text.count > 0 && !textArray.isEmpty {
        if charsArray.contains(new_text.first!) {
            new_text.removeFirst()
            textArray.removeFirst()
        } else {
            break
        }
    }
    
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
            
assert(f(text: "asfdellos", chars: "Ta") == "sfdellos")
