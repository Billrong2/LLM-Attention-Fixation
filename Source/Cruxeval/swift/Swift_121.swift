/// 
func f(s: String) -> String {
    let nums = s.filter { $0.isNumber }
    if nums.isEmpty {
        return "none"
    }
    let numbers = nums.split(separator: ",").compactMap { Int(String($0)) }
    guard let maxNum = numbers.max() else {
        return "none"
    }
    return String(maxNum)
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
            
assert(f(s: "01,001") == "1001")
