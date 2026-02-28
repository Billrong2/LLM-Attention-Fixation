/// 
func f(numbers: [Int], index: Int) -> [Int] {
    var updatedNumbers = numbers
    var newIndex = index
    for n in numbers[index...] {
        updatedNumbers.insert(n, at: newIndex)
        newIndex += 1
    }
    return Array(updatedNumbers.prefix(newIndex))
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
            
assert(f(numbers: [-2, 4, -4], index: 0) == [-2, 4, -4])
