extension String: Error {}

func f(array: [Int]) -> [Result<Int, String>] {
    var newArray = array.map { Result<Int, String>.success($0) }
    let zeroLen = (newArray.count - 1) % 3
    for i in 0..<zeroLen {
        newArray[i] = .failure("0")
    }
    for i in stride(from: zeroLen + 1, to: newArray.count, by: 3) {
        newArray[i - 1] = .failure("0")
        newArray[i] = .failure("0")
        if i + 1 < newArray.count {
            newArray[i + 1] = .failure("0")
        }
    }
    return newArray
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
            
assert(f(array: [9, 2]) == [.failure("0"), .success(2)])
