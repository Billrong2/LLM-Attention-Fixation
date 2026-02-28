/// 
func f(text: String, num_digits: Int) -> String {
    let width = max(1, num_digits)
    return String(repeating: "0", count: max(0, width - text.count)) + text
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
            
assert(f(text: "19", num_digits: 5) == "00019")
