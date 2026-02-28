/// 
func f(array: [Int], elem: Int) -> [Int] {
    var k = 0
    var newArray = array
    for i in newArray {
        if i > elem {
            newArray.insert(elem, at: k)
            break
        }
        k += 1
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
            
assert(f(array: [5, 4, 3, 2, 1, 0], elem: 3) == [3, 5, 4, 3, 2, 1, 0])
