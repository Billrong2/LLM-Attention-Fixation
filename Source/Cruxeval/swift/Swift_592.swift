/// 
func f(numbers: [Int]) -> [Int] {
    var newNumbers: [Int] = []
    for i in 0..<numbers.count {
        newNumbers.append(numbers[numbers.count - 1 - i])
    }
    return newNumbers
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
            
assert(f(numbers: [11, 3]) == [3, 11])
