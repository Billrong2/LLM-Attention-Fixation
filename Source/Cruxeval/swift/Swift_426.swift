/// 
func f(numbers: [Int], elem: Int, idx: Int) -> [Int] {
    guard idx < numbers.count else {
        return numbers + [elem]
    }
    var newArray = numbers
    newArray.insert(elem, at: idx)
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
            
assert(f(numbers: [1, 2, 3], elem: 8, idx: 5) == [1, 2, 3, 8])
