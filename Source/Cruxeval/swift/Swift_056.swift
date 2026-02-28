/// 
func f(sentence: String) -> Bool {
    for c in sentence {
        if !c.unicodeScalars.allSatisfy({ $0.isASCII }) {
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
            
assert(f(sentence: "1z1z1") == true)
