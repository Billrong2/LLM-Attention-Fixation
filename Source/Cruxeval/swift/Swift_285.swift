/// 
func f(text: String, ch: String) -> Int {
    return text.filter { $0 == Character(ch) }.count
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
            
assert(f(text: "This be Pirate's Speak for 'help'!", ch: " ") == 5)
