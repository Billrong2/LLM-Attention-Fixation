/// 
func f(array: [Int]) -> [Int] {
    var a: [Int] = []
    var reversedArray = array.reversed()
    for element in reversedArray {
        if element != 0 {
            a.append(element)
        }
    }
    return a.reversed()
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
            
assert(f(array: [] as [Int]) == [] as [Int])
