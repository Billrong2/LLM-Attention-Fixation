/// 
func f(array1: [Int], array2: [Int]) -> [Int : [Int]] {
    var result = [Int: [Int]]()
    for key in array1 {
        result[key] = array2.filter { $0 < key * 2 }
    }
    return result
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
            
assert(f(array1: [0, 132], array2: [5, 991, 32, 997]) == [0 : [] as [Int], 132 : [5, 32]])
