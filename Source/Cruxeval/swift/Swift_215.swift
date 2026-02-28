/// 
func f(text: String) -> String {
    var new_text = text
    while new_text.count > 1 && new_text.first == new_text.last {
        new_text = String(new_text.dropFirst().dropLast())
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
            
assert(f(text: ")") == ")")
