import Foundation

func f(nums: [String]) -> [String] {
    return nums.dropFirst().map { val in
        String(format: "%0\(nums[0])d", Int(val) ?? 0)
    }
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
            
assert(f(nums: ["1", "2", "2", "44", "0", "7", "20257"]) == ["2", "2", "44", "0", "7", "20257"])
