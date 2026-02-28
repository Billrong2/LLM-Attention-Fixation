extension Array: Error {}

func f(first: [Int], second: [Int]) -> Result<String, [Int]> {
    if first.count < 10 || second.count < 10 {
        return .success("no")
    }
    for i in 0..<5 {
        if first[i] != second[i] {
            return .success("no")
        }
    }
    var mutableFirst = first
    mutableFirst.append(contentsOf: second)
    return .failure(mutableFirst)
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
            
assert(f(first: [1, 2, 1], second: [1, 1, 2]) == .success("no"))
