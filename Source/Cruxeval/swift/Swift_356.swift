/// 
func f(array: [Int], num: Int) -> [Int] {
    var reverse = false
    var num = num
    if num < 0 {
        reverse = true
        num *= -1
    }
    var array = Array(array.reversed())
    array = Array(repeating: array, count: num).flatMap { $0 }
    
    if reverse {
        array = Array(array.reversed())
    }
    return array
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
            
assert(f(array: [1, 2], num: 1) == [2, 1])
