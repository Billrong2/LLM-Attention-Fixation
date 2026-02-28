/// 
func f(text: String) -> Bool {
    let endings = [".", "!", "?"]
    
    for ending in endings {
        if text.hasSuffix(ending) {
            return true
        }
    }
    
    return false
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
            
assert(f(text: ". C.") == true)
