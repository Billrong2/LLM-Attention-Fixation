/// 
func f(text1: String, text2: String) -> Int {
    var nums: [Int] = []
    for i in 0..<text2.count {
        nums.append(text1.filter { $0 == text2[text2.index(text2.startIndex, offsetBy: i)] }.count)
    }
    return nums.reduce(0, +)
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
            
assert(f(text1: "jivespdcxc", text2: "sx") == 2)
