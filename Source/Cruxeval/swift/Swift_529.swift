/// 
func f(array: [Int]) -> [Int] {
    var prev = array[0]
    var newArray = array
    var i = 1
    while i < newArray.count {
        if prev != newArray[i] {
            newArray[i] = newArray[i]
        } else {
            newArray.remove(at: i)
            i -= 1
        }
        prev = newArray[i]
        i += 1
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
            
assert(f(array: [1, 2, 3]) == [1, 2, 3])
