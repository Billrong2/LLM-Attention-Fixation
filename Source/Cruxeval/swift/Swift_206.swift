/// 
func f(a: String) -> String {
    return a.split(separator: " ").joined(separator: " ")
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
            
assert(f(a: " h e l l o   w o r l d! ") == "h e l l o w o r l d!")
