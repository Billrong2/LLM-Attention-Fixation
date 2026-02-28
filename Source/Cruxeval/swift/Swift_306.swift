extension Int: Error {}

func f(nums: [Result<String, Int>]) -> [Int] {
    var digits: [Int] = []
    for num in nums {
        switch num {
        case .success(let stringNum):
            guard let intNum = Int(stringNum) else { continue }
            digits.append(intNum)
        case .failure(let intNum):
            digits.append(intNum)
        }
    }
    return digits
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
            
assert(f(nums: [.failure(0), .failure(6), .success("1"), .success("2"), .failure(0)]) == [0, 6, 1, 2, 0])
