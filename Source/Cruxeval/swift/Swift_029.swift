/// 
func f(text: String) -> String {
    let nums = text.filter { $0.isNumber }
    assert(nums.count > 0)
    return String(nums)
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
            
assert(f(text: "-123   \t+314") == "123314")
