/// 
func f(text: String) -> String {
    let new_text = text.map { c in
        return c.isNumber ? String(c) : "*"
    }
    return new_text.joined()
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
            
assert(f(text: "5f83u23saa") == "5*83*23***")
