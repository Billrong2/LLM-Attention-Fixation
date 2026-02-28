/// 
func f(array: [Int], values: [Int]) -> [Int] {
    var newArray = array
    newArray.reverse()
    for value in values {
        newArray.insert(value, at: newArray.count / 2)
    }
    newArray.reverse()
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
            
assert(f(array: [58], values: [21, 92]) == [58, 92, 21])
