/// 
func f(text: String, size: Int) -> String {
    var counter = text.count
    var text = text
    let halfSize = Int(size) / 2
    
    for _ in 0..<(size - size%2) {
        text = " " + text + " "
        counter += 2
        if counter >= size {
            return text
        }
    }
    
    return text
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
            
assert(f(text: "7", size: 10) == "     7     ")
