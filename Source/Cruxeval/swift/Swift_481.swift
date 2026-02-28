func f(values: [Int], item1: Int, item2: Int) -> [Int] {
    var updatedValues = values
    if let firstValue = updatedValues.first, updatedValues.last == item2 {
        if !updatedValues.dropFirst().contains(firstValue) {
            updatedValues.append(firstValue)
        }
    } else if updatedValues.last == item1 {
        if let firstValue = updatedValues.first, firstValue == item2 {
            updatedValues.append(firstValue)
        }
    }
    return updatedValues
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
            
assert(f(values: [1, 1], item1: 2, item2: 3) == [1, 1])
