/// 
func f(text: String, digit: String) -> Int {
    let count = text.filter { String($0) == digit }.count
    return Int(digit)! * count
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
            
assert(f(text: "7Ljnw4Lj", digit: "7") == 7)
