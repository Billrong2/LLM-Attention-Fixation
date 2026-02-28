/// 
func f(text: String) -> Int {
    var counter = 0
    for char in text {
        if char.isLetter {
            counter += 1
        }
    }
    return counter
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
            
assert(f(text: "l000*") == 1)
