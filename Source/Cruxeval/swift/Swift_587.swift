func f(nums: [Int], fill: String) -> [Int : String] {
    var ans: [Int : String] = [:]
    for num in nums {
        ans[num] = fill
    }
    return ans
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
            
assert(f(nums: [0, 1, 1, 2], fill: "abcca") == [0 : "abcca", 1 : "abcca", 2 : "abcca"])
