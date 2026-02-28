/// 
func f(text: String, suffix: String, num: Int) -> Bool {
    let strNum = String(num)
    return text.hasSuffix(suffix + strNum)
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
            
assert(f(text: "friends and love", suffix: "and", num: 3) == false)
