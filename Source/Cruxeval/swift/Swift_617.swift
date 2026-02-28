/// 
func f(text: String) -> String {
    if text.utf8.allSatisfy({ $0 < 128 }) {
        return "ascii"
    } else {
        return "non ascii"
    }
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
            
assert(f(text: "<<<<") == "ascii")
